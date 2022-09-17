
import 'package:form_field_validator/form_field_validator.dart';

class Validations{

 static final emailValidator = MultiValidator([
   EmailValidator(errorText: 'Enter a valid email address'),
   RequiredValidator(errorText: 'Email address is required'),
 ]);

 static final passwordValidator = MultiValidator([
   RequiredValidator(errorText: 'Password is required'),
 ]);
}