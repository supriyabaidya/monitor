<%--
    Document   : index
    Created on : 7 Mar, 2018, 11:28:02 PM
    Author     : TomHardy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.io.*,java.util.*,java.net.*,org.json.simple.JSONObject" %>
<!DOCTYPE html>

<%! static int day = 3;
    public final static String AUTH_KEY_FCM = "AAAAcllSacU:APA91bFcDN-K6gAx4IkPEpMxzC8CTe5V2AcuVn2lpXggkumUIO7ijFXDr504dMC0jkPfhzDKWnLpGYWL14zMIbgCwS9DdWbWVa9BtrCt1fhufTbYzgQRqnH4YX4zi6cGoQJ0Q4rK47uL";
    public final static String API_URL_FCM = "https://fcm.googleapis.com/fcm/send";%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Monitor</title>

        <style >
            table {
                border:5px solid green;
                padding: 1px;
                border-spacing: 1px
            }
            td,th {
                text-align : left ;
                border:1px solid black;
                padding: 5px;
            }
        </style>

        <script src="jquery-1.10.2.js" ></script>
        <script type="text/javascript">

            var interval = 5000;

            function getSelectedCheckboxesArray() {
                var ch_list = Array();
                $("input:checkbox[type=checkbox]:checked").each(function () {
                    ch_list.push($(this).val());
                });
                return ch_list;
            }

            function displayUsers() {
                var check_list = Array();
                check_list = getSelectedCheckboxesArray();
                var noOfCheckedItems = check_list.length;

                if (noOfCheckedItems === 0) {
                    $.ajax({
                        type: "GET",
                        url: "DisplayUsers",
                        datatype: "html",
                        async: true,
                        success: function (data) {
                            $("#output").html(data);
                        }
                    });
                }
            }

            displayUsers();
            setInterval("displayUsers()", interval);

        </script>
    </head>
    <body>
        <h1>Hello World!</h1>

        <h2>A warm Welcome from Supriyo Baidya</h2>
        <h3>Checked Return Type </br> Test netbeans maven java web project 'Monitor' (including web service client) and deployed from netbeans .</h3>

        <form action="CallMonitor" >
            <input type="submit" value="open monitor" />
        </form>



        <%
            if (session.getAttribute("message") != null) {
                out.println(session.getAttribute("message"));
            }
            session.removeAttribute("message");
        %>

    <c:out value="${sessionScope.message}" />
    <c:remove var="message" scope="session" />

    <h4 id="output"></h4>

    <%!

// userDeviceIdKey is the device id you will query from your database
        public static void pushFCMNotification(String userDeviceIdKey) throws Exception {

            String authKey = AUTH_KEY_FCM; // You FCM AUTH key
            String FMCurl = API_URL_FCM;

            URL url = new URL(FMCurl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setUseCaches(false);
            conn.setDoInput(true);
            conn.setDoOutput(true);

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "key=" + authKey);
            conn.setRequestProperty("Content-Type", "application/json");

            JSONObject json = new JSONObject();
            json.put("to", userDeviceIdKey.trim());
            JSONObject info = new JSONObject();
            info.put("title", "Notificatoin Title"); // Notification title
            info.put("body", "Hello Test notification"); // Notification body
            json.put("notification", info);

            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(json.toString());
            wr.flush();
            conn.getInputStream();
        }
    %>


    <%
//             Set refresh, autoload time as 5 seconds
//            response.setIntHeader("Refresh", 5);
        // Get current time
        Calendar calendar = new GregorianCalendar();
        String am_pm;

        int hour = calendar.get(Calendar.HOUR);
        int minute = calendar.get(Calendar.MINUTE);
        int second = calendar.get(Calendar.SECOND);

        if (calendar.get(Calendar.AM_PM)
                == 0) {
            am_pm = "AM";
        } else {
            am_pm = "PM";
        }
        String CT = hour + ":" + minute + ":" + second + " " + am_pm;

        out.println("Current Time: " + CT + "\n");

//            pushFCMNotification("cwOJV4SbJWI:APA91bFJuun4dUb_al7B8cDCSvMHbWJBhh3NvkCrQ-d_fXIP5i5VCkYgSjw4kzwjAH7c1xsFTwaRilPIhbplPoKwS64du04YCjJAfhPysJy-75VBmD4RW7gvo42gpMALXU9DGqral99U");

    %>
</body>
</html>