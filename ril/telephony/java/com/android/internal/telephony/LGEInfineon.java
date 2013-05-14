/*
 * Copyright (C) 2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.android.internal.telephony;

import static com.android.internal.telephony.RILConstants.*;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Message;
import android.os.Parcel;

import java.util.ArrayList;
import java.util.Collections;

import android.telephony.PhoneNumberUtils;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;

/* NITZ stuffs */
import android.os.SystemProperties;
import java.util.Date;
import java.text.SimpleDateFormat;

public class LGEInfineon extends RIL implements CommandsInterface {

    public LGEInfineon(Context context, int networkMode, int cdmaSubscription) {
        super(context, networkMode, cdmaSubscription);
        PhoneStateListener mPhoneStateListener = new PhoneStateListener() {
            @Override
            public void onCallStateChanged(int state, String incomingNumber) {
                /* Higher state wins, unless going back to idle */
                if (state == TelephonyManager.CALL_STATE_IDLE || state > mCallState)
                    mCallState = state;
            }
        };

        // register for phone state notifications.
        ((TelephonyManager)context.getSystemService(Context.TELEPHONY_SERVICE))
            .listen(mPhoneStateListener,
                    PhoneStateListener.LISTEN_CALL_STATE);
    }

    protected int mCallState = TelephonyManager.CALL_STATE_IDLE;

    private int RIL_REQUEST_HANG_UP_CALL = 182;

    /* We're not actually changing REQUEST_GET_IMEI, but it's one
       of the first requests made after enabling the radio, and it
       isn't repeated while the radio is on, so a good candidate to
       inject initialization ops */

    @Override
    public void
    getIMEI(Message result) {
        // RIL_REQUEST_LGE_SEND_COMMAND
        RILRequest rrLSC = RILRequest.obtain(
                0x112, null);
        rrLSC.mp.writeInt(1);
        rrLSC.mp.writeInt(0);
        send(rrLSC);

        // The original (and unmodified) IMEI request
        RILRequest rr = RILRequest.obtain(RIL_REQUEST_GET_IMEI, result);

        if (RILJ_LOGD) riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));

        send(rr);
    }

    @Override
    public void
    hangupWaitingOrBackground (Message result) {
        RILRequest rr = RILRequest.obtain(mCallState == TelephonyManager.CALL_STATE_OFFHOOK ?
                                        RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND :
                                        RIL_REQUEST_HANG_UP_CALL,
                                        result);

        if (RILJ_LOGD) riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));

        send(rr);
    }

    private static byte[] hexStringToByteArray(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                    + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }

    static final int RIL_UNSOL_LGE_SIM_STATE_CHANGED = 1060;
    static final int RIL_UNSOL_LGE_SIM_STATE_CHANGED_NEW = 1061;
    static final int RIL_UNSOL_LGE_XCALLSTAT = 1052;
    static final int RIL_UNSOL_LGE_UNSOL = 1080;
    static final int RIL_REQUEST_LGE_SET_CPATH = 252;

    @Override
    public void
    queryCallForwardStatus(int cfReason, int serviceClass,
                String number, Message response) {
        RILRequest rr
            = RILRequest.obtain(RIL_REQUEST_QUERY_CALL_FORWARD_STATUS, response);

        rr.mp.writeInt(2); // 2 is for query action, not in used anyway
        rr.mp.writeInt(cfReason);
        rr.mp.writeInt(511);
        rr.mp.writeInt(PhoneNumberUtils.toaFromString(number));
        rr.mp.writeString(number);
        rr.mp.writeInt (0);

        if (RILJ_LOGD) riljLog(rr.serialString() + "> " + requestToString(rr.mRequest)
                + " " + cfReason + " " + serviceClass);

        send(rr);
    }

    @Override
    protected Object
    responseCallForward(Parcel p) {
        int numInfos;
        CallForwardInfo infos[];

        numInfos = p.readInt();

        infos = new CallForwardInfo[numInfos];

        for (int i = 0 ; i < numInfos ; i++) {
            infos[i] = new CallForwardInfo();

            infos[i].status = p.readInt();
            infos[i].reason = p.readInt();
            infos[i].serviceClass = p.readInt();
            infos[i].toa = p.readInt();
            infos[i].number = PhoneNumberUtils.stripSeparators(p.readString());
            infos[i].timeSeconds = p.readInt();
        }

        return infos;
    }

    @Override
    public void
    setMute (boolean enableMute, Message response) {
        RILRequest rr
                = RILRequest.obtain(RIL_REQUEST_LGE_SET_CPATH, response);

        if (RILJ_LOGD) riljLog(rr.serialString() + "> " + requestToString(rr.mRequest)
                            + " " + enableMute);

        rr.mp.writeInt(1);
        rr.mp.writeInt(enableMute ? 7 : 8);

        send(rr);
    }

    @Override
    protected void
    processUnsolicited (Parcel p) {
        Object ret;
        int dataPosition = p.dataPosition(); // save off position within the Parcel
        int response = p.readInt();
        
        String basebandVersion = SystemProperties.get("gsm.version.baseband");
        String[] basebandSplit = basebandVersion == null ? new String[1] : basebandVersion.split("-");

        switch(response) {
            case RIL_UNSOL_ON_USSD: ret =  responseStrings(p); break;
            case RIL_UNSOL_LGE_UNSOL: ret =  responseVoid(p); break; // RIL_UNSOL_LGE_FACTORY_READY
            case RIL_UNSOL_LGE_SIM_STATE_CHANGED:
            case RIL_UNSOL_LGE_SIM_STATE_CHANGED_NEW: ret =  responseVoid(p); break;
            case RIL_UNSOL_NITZ_TIME_RECEIVED: ret =  responseNitz(p); break;
	    case RIL_UNSOL_LGE_XCALLSTAT: ret = responseVoid(p); break;
            default:
                // Rewind the Parcel
                p.setDataPosition(dataPosition);

                // Forward responses that we are not overriding to the super class
                super.processUnsolicited(p);
                return;
        }
        switch(response) {
	    case RIL_UNSOL_LGE_XCALLSTAT:
		break;
            case RIL_UNSOL_ON_USSD:
                String[] resp = (String[])ret;

                if (resp.length < 2) {
                    resp = new String[2];
                    resp[0] = ((String[])ret)[0];
                    resp[1] = null;
                }
                if (resp[1].length()%2 == 0 && resp[1].matches("[0-9A-F]+")) {
                    try { 
                        resp[1] = new String(hexStringToByteArray(resp[1]), "UTF-16");
                    } catch (java.io.UnsupportedEncodingException uex) { 
                        // encoding not supported, should never get here 
                    } catch (java.io.IOException iox) { 
                        // you will get here if the original sequence wasn't UTF-8 or ASCII 
                    } 
                }
                if (RILJ_LOGD) unsljLogMore(response, resp[0]);
                if (mUSSDRegistrant != null) {
                    mUSSDRegistrant.notifyRegistrant(
                        new AsyncResult (null, resp, null));
                }
                break;
            case RIL_UNSOL_LGE_UNSOL:
                /* Adjust request IDs */
            	if ("LGP990AT".equalsIgnoreCase(basebandSplit[0])) {
            		RIL_REQUEST_HANG_UP_CALL = 206;
            	}
                break;
            case RIL_UNSOL_LGE_SIM_STATE_CHANGED:
            case RIL_UNSOL_LGE_SIM_STATE_CHANGED_NEW:
                if (RILJ_LOGD) unsljLog(response);

                if (mIccStatusChangedRegistrants != null) {
                    mIccStatusChangedRegistrants.notifyRegistrants();
                }
                break;
            case RIL_UNSOL_NITZ_TIME_RECEIVED:
                if (RILJ_LOGD) unsljLogRet(response, ret);

                // has bonus long containing milliseconds since boot that the NITZ
                // time was received
                long nitzReceiveTime = p.readLong();

                Object[] result = new Object[2];

                result[0] = ret;
                result[1] = Long.valueOf(nitzReceiveTime);

                // RIL_UNSOL_NITZ_TIME_RECEIVED handling
                boolean ignoreNitz = false;
                if (SystemProperties.getBoolean(TelephonyProperties.PROPERTY_IGNORE_NITZ, false)) {
                    ignoreNitz = true;
                } else {
                    if ("LGSU660AT".equalsIgnoreCase(basebandSplit[0])) {
                       ignoreNitz = true;
                    } else {
                    	// Detect V28e or newer BBs like
                        // LGP990AT-00-V30a-EUR-XXX-NOV-30-2012+0
                        if ("LGP990AT".equalsIgnoreCase(basebandSplit[0])
                        		&& (basebandSplit.length > 2)
                               	 	&& (basebandSplit[2].length() == 4)
                                	&& (basebandSplit[2].toLowerCase().startsWith("v"))
                                	&& (basebandSplit[2].compareToIgnoreCase("V28e") >= 0)) {
                        	ignoreNitz = true;
                        }
                    }
                }
                if (ignoreNitz) {
                    if (RILJ_LOGD) riljLog("ignoring UNSOL_NITZ_TIME_RECEIVED");
                } else {
                    if (mNITZTimeRegistrant != null) {

                        mNITZTimeRegistrant
                            .notifyRegistrant(new AsyncResult (null, result, null));
                    } else {
                        // in case NITZ time registrant isnt registered yet
                        mLastNITZTimeInfo = result;
                    }
                }
            break;
        }

    }

    private Object
    responseNitz(Parcel p) {
        int tzoffset, dst=0;
        String parceldata, parcelextra;
        String response;
        SimpleDateFormat dateFormatter;
        SimpleDateFormat dateParser;

        /* Get the actual date string */
        parceldata = p.readString();

        /* Break 12/11/6,19:0:15+44,1 into...
         * parcelitem[0] (date), hourbreak[0] (time), 
         * hourbreak[1] (tz offset), parcelitem[2] (dst) */

        String [] parcelitem = parceldata.split(",");
        String [] hourbreak = parcelitem[1].split("[\\+-]");
        parceldata = parcelitem[0] + "," + hourbreak[0]; // assuming there is always one comma at least
        tzoffset = Integer.parseInt(hourbreak[1]); // TZ diff in quarter-hours
        if (parcelitem[1].matches(".*-[0-9]+$")) tzoffset *= -1;

        parcelextra = (parcelitem.length > 2 ? parcelitem[2] : "0");
        dst = Integer.parseInt(parcelextra);

        /* WTH... Date may come with 4 digits in the year, reduce to 2 */
        try {
            dateFormatter = new SimpleDateFormat("yy/MM/dd,HH:mm:ss");
            dateParser = new SimpleDateFormat("yy/MM/dd,HH:mm:ss");

            /* Directly calculate UTC time using DST Offset */
            int offset = tzoffset*15*60*1000;	// DST corrected
            long when = dateParser.parse(parceldata).getTime() - offset;
            Date d = new Date(when);
            response = dateFormatter.format(d);

        } catch (java.text.ParseException tpe) {
            riljLog("NITZ TZ conversion failed: " + tpe);
            response = parceldata;
        }

        /* Append the timezone */
        response = response + ((tzoffset < 0) ? "" : "+") + tzoffset;
        /* Add DST */
        response = response + "," + dst;

        return response;
    }

    @Override
    protected Object
    responseCallList(Parcel p) {
        int num;
        int voiceSettings;
        ArrayList<DriverCall> response;
        DriverCall dc;

        num = p.readInt();
        response = new ArrayList<DriverCall>(num);

        if (RILJ_LOGV) {
            riljLog("responseCallList: num=" + num +
                    " mEmergencyCallbackModeRegistrant=" + mEmergencyCallbackModeRegistrant +
                    " mTestingEmergencyCall=" + mTestingEmergencyCall.get());
        }
        for (int i = 0 ; i < num ; i++) {
            dc = new DriverCall();

            dc.state = DriverCall.stateFromCLCC(p.readInt());
            dc.index = p.readInt();
            dc.TOA = p.readInt();
            dc.isMpty = (0 != p.readInt());
            dc.isMT = (0 != p.readInt());
            dc.als = p.readInt();
            voiceSettings = p.readInt();
            dc.isVoice = (0 == voiceSettings) ? false : true;
            dc.isVoicePrivacy = (0 != p.readInt());
            dc.number = p.readString();
            int np = p.readInt();
            dc.numberPresentation = DriverCall.presentationFromCLIP(np);
            dc.name = p.readString();
            dc.namePresentation = p.readInt();
            int uusInfoPresent = p.readInt();
            if (uusInfoPresent == 1) {
                dc.uusInfo = new UUSInfo();
                dc.uusInfo.setType(p.readInt());
                dc.uusInfo.setDcs(p.readInt());
                byte[] userData = p.createByteArray();
                dc.uusInfo.setUserData(userData);
                riljLogv(String.format("Incoming UUS : type=%d, dcs=%d, length=%d",
                                dc.uusInfo.getType(), dc.uusInfo.getDcs(),
                                dc.uusInfo.getUserData().length));
                riljLogv("Incoming UUS : data (string)="
                        + new String(dc.uusInfo.getUserData()));
                riljLogv("Incoming UUS : data (hex): "
                        + IccUtils.bytesToHexString(dc.uusInfo.getUserData()));
            } else {
                riljLogv("Incoming UUS : NOT present!");
            }

            // star current calls come with additional info in the parcel,
            // read it to forward the position
            p.readString(); //cdnipNumber
            p.readInt(); //signal

            // Make sure there's a leading + on addresses with a TOA of 145
            dc.number = PhoneNumberUtils.stringFromStringAndTOA(dc.number, dc.TOA);

            response.add(dc);

            if (dc.isVoicePrivacy) {
                mVoicePrivacyOnRegistrants.notifyRegistrants();
                riljLog("InCall VoicePrivacy is enabled");
            } else {
                mVoicePrivacyOffRegistrants.notifyRegistrants();
                riljLog("InCall VoicePrivacy is disabled");
            }
        }

        Collections.sort(response);

        if ((num == 0) && mTestingEmergencyCall.getAndSet(false)) {
            if (mEmergencyCallbackModeRegistrant != null) {
                riljLog("responseCallList: call ended, testing emergency call," +
                            " notify ECM Registrants");
                mEmergencyCallbackModeRegistrant.notifyRegistrant();
            }
        }

        return response;
    }
}
