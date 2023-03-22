import 'package:trade_plan/core/services/order_result_service.dart';

class OrderResultServiceImpl implements OrderResultService {
  @override
  double calculateMoneyResult(
      {required double points,
      required double pointsPerTick,
      required double moneyByTick,
      required contractNumber,
      double? tax}) {
    double result = ((points / pointsPerTick) * moneyByTick) * contractNumber;

    if (tax != null) {
      result = result - tax;
    }

    return result;
  }

  @override
  double calculateTaxByContract(
      {required contractNumber, required taxByContract}) {
    return taxByContract * contractNumber;
  }

  @override
  double getRiskReturn() {
    // TODO: implement getRiskReturn
    throw UnimplementedError();
  }
}
