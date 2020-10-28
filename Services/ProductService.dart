import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:mock_web_server/mock_web_server.dart';

import '../Models/Utility.dart';

class ProductService{
    /*[Attributes]*/
    Utility utility = new Utility();
    MockWebServer _server;
    

    /*[Contsructors]*/
    ProductService(){
        _server = new MockWebServer();
        _server.start();
    }


    /*[Methods]*/

    /*
    * @Description: Get a list of items in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getPills() async
    {
        this.utility.Custom_Print("START: getPills");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/pills.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'pills');
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'pills';

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getPills");
        return results;
    }


    /*
    * @Description: Get item in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getPill(int product_id) async
    {
        this.utility.Custom_Print("START: getPill");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/pills_'+product_id.toString()+'.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'pill/'+product_id.toString());
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'pill/'+product_id.toString();

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getPill");
        return results;
    }


    /*
    * @Description: Get a list of items in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getFirstAids() async
    {
        this.utility.Custom_Print("START: getFirstAids");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/first_aids.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'first_aids');
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'first_aids';

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getFirstAids");
        return results;
    }


    /*
    * @Description: Get item in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getFirstAid(int product_id) async
    {
        this.utility.Custom_Print("START: getFirstAids");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/first_aids_'+product_id.toString()+'.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'first_aid/'+product_id.toString());
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'first_aid/'+product_id.toString();

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getFirstAids");
        return results;
    }


    /*
    * @Description: Get a list of items in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getDoctors() async
    {
        this.utility.Custom_Print("START: getDoctors");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/doctors.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'doctors');
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'doctors';

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getDoctors");
        return results;
    }


    /*
    * @Description: Get item in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getDoctor(int product_id) async
    {
        this.utility.Custom_Print("START: getDoctor");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/doctors_'+product_id.toString()+'.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'doctor/'+product_id.toString());
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'doctor/'+product_id.toString();

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getDoctor");
        return results;
    }


    /*
    * @Description: Get a list of items in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getEmergencies() async
    {
        this.utility.Custom_Print("START: getEmergency");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/emergency.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'emergencies');
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'emergencies';

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getEmergencies");
        return results;
    }


    /*
    * @Description: Get item in the database
    *
    * @param:
    *
    * @return: JSON
    */
    Future<dynamic> getEmergency(int product_id) async
    {
        this.utility.Custom_Print("START: getEmergency");
        //Variables/
        BuildContext context;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        dynamic results;
        final Map<String, dynamic> formData = {
            //"id": 1,
        };

        //Mock API Service
        //Load the JSON file from the "Assets" folder
        String jsonString = await rootBundle.loadString('lib/Projects/My_Pharmacy_App/Assets/API/emergency_'+product_id.toString()+'.json');
        Map<String, String> ServerHeaders = new Map();
        ServerHeaders["X-Server"] = "MockDart";
        _server.enqueue(body: jsonString, httpCode: 200, headers: ServerHeaders, delay: new Duration(milliseconds: 1000));

        utility.Custom_Print(utility.App_API_URL + 'emergency/'+product_id.toString());
        //utility.Custom_Print('formData: '+formData.toString());


        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        String url = utility.App_API_URL + 'emergency/'+product_id.toString();

        //HttpClientRequest request = await client.getUrl(Uri.parse(url));
        HttpClientRequest request = await client.get(_server.host, _server.port, url);

        request.headers.set('content-type', 'application/json');

        //request.add(utf8.encode(json.encode(formData)));

        HttpClientResponse response = await request.close();

        final dynamic responseData = await response.transform(utf8.decoder).join();
        final dynamic headers = response.headers;
        
        switch(response.statusCode) { 
            case 200: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 201: {
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;

            case 202: { 
                dynamic items = json.decode(responseData);
                results = items;
            } 
            break;
          
            case 400: {
                dynamic error = json.decode(responseData);
            
                return Future.error(error);
            }

            case 401: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 402: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 403: {
                dynamic error = json.decode(responseData);

                return Future.error(error );
            }

            case 404: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }

            case 419: {
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
                
            default: { 
                dynamic error = json.decode(responseData);

                return Future.error(error);
            }
        }

        utility.Custom_Print("STOP: getEmergency");
        return results;
    }
}