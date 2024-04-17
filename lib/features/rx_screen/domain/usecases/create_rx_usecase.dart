import 'package:aasa_emr/common/usecase/usecase.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/rx_screen/domain/repository/rx_repository.dart';

class CreateRxUseCase extends Usecase<Future<void>, RxModel> {
  final RxRepository rxRepository;
  CreateRxUseCase({required this.rxRepository});

  @override
  Future<void> execute(RxModel params) async {
    try {
      await rxRepository.createRx(params);
    } catch (e) {
      rethrow;
    }
  }
}
