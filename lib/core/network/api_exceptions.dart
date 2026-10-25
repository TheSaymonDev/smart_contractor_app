import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiException('রিকোয়েস্টটি বাতিল করা হয়েছে');
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException('ইন্টারনেট সংযোগ অত্যন্ত ধীর। আবার চেষ্টা করুন');
      case DioExceptionType.badResponse:
        return ApiException(
          _handleStatusCode(
            dioError.response?.statusCode,
            dioError.response?.data,
          ),
        );
      case DioExceptionType.connectionError:
        return ApiException('কোনো ইন্টারনেট সংযোগ পাওয়া যায়নি');
      default:
        return ApiException('একটি অনাকাঙ্ক্ষিত সমস্যা ঘটেছে');
    }
  }

  static String _handleStatusCode(int? statusCode, dynamic responseData) {
    switch (statusCode) {
      case 400:
        if (responseData is Map && responseData.containsKey('message')) {
          return responseData['message'].toString();
        }
        return 'ভুল তথ্য দেওয়া হয়েছে';
      case 401:
        return 'আপনার সেশনটি শেষ হয়ে গেছে। পুনরায় লগইন করুন';
      case 403:
        return 'আপনার এই সার্ভিসটি ব্যবহারের অনুমতি নেই';
      case 404:
        return 'অনুরোধকৃত তথ্যটি পাওয়া যায়নি';
      case 500:
        return 'সার্ভারে অভ্যন্তরীণ সমস্যা তৈরি হয়েছে';
      default:
        return 'সার্ভারের সাথে সংযোগ স্থাপন করা সম্ভব হয়নি';
    }
  }

  @override
  String toString() => message;
}
