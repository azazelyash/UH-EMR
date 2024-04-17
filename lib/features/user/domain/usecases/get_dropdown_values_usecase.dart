import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/user/data/models/dropdown_values.dart';
import 'package:aasa_emr/features/user/domain/repository/user_repository.dart';

class GetDropdownValuesUsecase extends Usecase<Future<DropdownValues>, void> {
  final UserRepository userRepository;

  GetDropdownValuesUsecase({required this.userRepository});
  @override
  Future<DropdownValues> execute(void params) async {
    try {
      return await userRepository.getDropdownValues();
    } catch (e) {
      rethrow;
    }
  }
}
