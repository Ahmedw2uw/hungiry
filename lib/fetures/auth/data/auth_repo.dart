import 'package:dio/dio.dart'; // تأكد من وجود هذا الاستيراد لحل مشكلة FormData
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/fetures/auth/data/user_model.dart';

class AuthRepo {
  final ApiServices apiServices = ApiServices();

  //! 1. Login - النسخة المتوافقة مع الـ Log الخاص بك
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiServices.post('/login', {
        'email': email,
        'password': password,
      });

      print("Raw Response: $response");

      // الوصول للبيانات بناءً على الـ Log: response['data']
      final Map<String, dynamic>? dataContent = response['data'];

      if (dataContent == null) {
        throw ApiError(message: "رد السيرفر غير مكتمل");
      }

      final userData = dataContent['user'];
      final String? token = dataContent['token'];

      if (userData == null) {
        throw ApiError(message: "لم يتم العثور على بيانات المستخدم في الرد");
      }

      // تجهيز البيانات للموديل الخاص بك
      // ملاحظة: جلبنا الاسم من الايميل مؤقتاً إذا لم يوجد في الميتاداتا
      String name = "";
      if (userData['user_metadata'] != null &&
          userData['user_metadata']['name'] != null) {
        name = userData['user_metadata']['name'];
      } else {
        name = userData['email'].split('@')[0]; // يأخذ الجزء قبل @ كاسم افتراضي
      }

      final Map<String, dynamic> finalJson = {
        'name': name,
        'email': userData['email'] ?? "",
        'token': token,
        'image': userData['image'] ?? "",
        'address': userData['address'] ?? "",
        'phoneNumber': userData['phoneNumber'] ?? "",
        'Visa': userData['Visa'] ?? "",
      };

      final user = UserModel.fromjson(finalJson);

      // حفظ التوكن في الجهاز
      if (token != null) {
        await PrefHelpers.saveToken(token);
      }

      return user;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['error'] ?? "خطأ في البريد أو كلمة المرور";
      throw ApiError(message: errorMessage);
    } catch (e) {
      print("Detailed Error during parsing: $e");
      throw ApiError(message: "حدث خطأ في قراءة البيانات: ${e.toString()}");
    }
  }

  //! 2. Register (إنشاء حساب جديد)
  Future<UserModel> register(String email, String password, String name) async {
    try {
      // 1. إنشاء الـ FormData بشكل صريح
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        'name': name,
      });

      // 2. إرسال الطلب (الآن لن يظهر خطأ لأننا عدلنا ApiServices)
      final response = await apiServices.post('/register', formData);

      // 3. استخراج البيانات (نفس هيكل اللوجن الذي نجح معك)
      final Map<String, dynamic>? dataContent = response['data'];

      if (dataContent == null) {
        throw ApiError(message: "رد السيرفر غير مكتمل");
      }

      final userData = dataContent['user'];
      final String? token = dataContent['token'];

      if (userData == null) {
        throw ApiError(message: "فشل إنشاء الحساب");
      }

      // 4. تجهيز البيانات للموديل
      final Map<String, dynamic> finalJson = {
        'name': name,
        'email': userData['email'] ?? email,
        'token': token,
        'image': userData['image'] ?? "",
        'address': userData['address'] ?? "",
        'phoneNumber': userData['phoneNumber'] ?? "",
        'Visa': userData['Visa'] ?? "",
      };

      return UserModel.fromjson(finalJson);
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['error'] ?? "فشل تسجيل البيانات";
      throw ApiError(message: errorMessage);
    } catch (e) {
      throw ApiError(message: "حدث خطأ أثناء التسجيل: ${e.toString()}");
    }
  }

//! 3. Logout (تسجيل الخروج)
  Future<void> logout() async {
    try {
      // إرسال طلب للسيرفر (اختياري لكن مفيد لإنهاء الجلسة برمجياً)
      // نرسل خريطة فارغة {} لأن الدالة تتوقع dynamic body الآن
      await apiServices.post('/logout', {});
    } catch (e) {
      // لا نحتاج لرمي خطأ هنا لأن الأولوية لمسح التوكن محلياً
      print("Logout server error: $e");
    } finally {
      // مسح التوكن من الشيرد بريفرنسز لضمان خروج المستخدم
      await PrefHelpers.clearToken();
    }
  }

  //! 4. Get User Data (جلب بيانات الملف الشخصي)
  Future<UserModel> getUserData() async {
    try {
      final response = await apiServices.get('/profile');
      
      // الوصول للبيانات داخل data ثم user كما فعلنا في اللوجن
      final userData = response['data']?['user'] ?? response['user'] ?? response;
      
      return UserModel.fromjson(userData);
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ?? "فشل جلب البيانات";
      throw ApiError(message: msg);
    } catch (e) {
      throw ApiError(message: "خطأ في استلام البيانات من السيرفر");
    }
  }

  //! 5. Update User Data (تحديث الملف الشخصي)
  Future<UserModel> updateUser(String name, String email) async {
    try {
      final response = await apiServices.post('/update-profile', {
        'name': name,
        'email': email,
      });

      // استخراج البيانات المحدثة
      final userData = response['data']?['user'] ?? response['user'] ?? response;

      // دمج الاسم الجديد يدوياً لضمان تحديثه في الموديل
      final Map<String, dynamic> finalData = {
        ...userData,
        'name': name,
      };

      return UserModel.fromjson(finalData);
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ?? "فشل تحديث البيانات";
      throw ApiError(message: msg);
    } catch (e) {
      throw ApiError(message: "حدث خطأ غير متوقع أثناء التحديث");
    }
  }

  //! 6. Change Password (تغيير كلمة المرور)
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      await apiServices.post('/change-password', {
        'old_password': oldPassword,
        'new_password': newPassword,
      });
    } on DioException catch (e) {
      // سوبابيز تعيد أخطاء كلمة المرور بوضوح، سنمررها للمستخدم
      final msg = e.response?.data?['error'] ?? "فشل تغيير كلمة المرور";
      throw ApiError(message: msg);
    }
  }

  //! 7. Forget Password (استعادة كلمة المرور)
  Future<void> forgetPassword(String email) async {
    try {
      await apiServices.post('/forgot-password', {
        'email': email,
      });
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ?? "فشل إرسال بريد استعادة كلمة المرور";
      throw ApiError(message: msg);
    }
  }}