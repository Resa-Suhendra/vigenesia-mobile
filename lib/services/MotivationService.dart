import 'package:vigenesia/model/MotivationModel.dart';
import 'package:vigenesia/utils/ConstantUtils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MotivationService {

  static const String BASE_URL = ConstantUtils.base_url;

  static Future<List<MotivationModel>> getMotivationByIduser(String idUser) async {
    List<MotivationModel> listMotivation = [];

    try {
      // Replace these with your form data parameters
      var apiUrl = Uri.parse('$BASE_URL/get_motivasi');
      var formData = {
        'iduser': idUser,
      };

      // Encode the form data into the query parameters
      apiUrl = apiUrl.replace(queryParameters: formData);

      // Make the GET request
      var response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        print(response.body.toString());
        List<dynamic> data = json.decode(response.body);
        data.forEach((element) {
          listMotivation.add(MotivationModel.fromJson(element));
        });
        return listMotivation.reversed.toList();
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return listMotivation;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return listMotivation;
    }
  }

  static Future<bool> createMotivation(MotivationModel motivation) async {
    const String url = '$BASE_URL/dev/postmotivasi';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: motivation.toJsonAdd(),
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        print(response.body.toString());
        return true;
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return false;
    }
  }

  static Future<bool> updateMotivation(MotivationModel motivation) async {
    const String url = '$BASE_URL/dev/putmotivasi';

    try {
      final response = await http.put(
        Uri.parse(url),
        body: motivation.toJsonUpdate(),
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        print(response.body.toString());
        return true;
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return false;
    }
  }

  static deleteMotivation(String idMotivation) async {
    const String url = '$BASE_URL/dev/deletemotivasi';

    try {
      final response = await http.delete(
        Uri.parse(url),
        body: {
          'id': idMotivation,
        },
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        print(response.body.toString());
        return response.body.toString();
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return null;
    }
  }
}