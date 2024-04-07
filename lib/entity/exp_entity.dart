import 'package:moving_target_select/consts/core_consts.dart';

enum ExpType  {
  acc,
  deAcc,
  uniSpeed
}

String expTypeToString(ExpType expType) {
  switch(expType) {
    case ExpType.acc:
      return '가속';
    case ExpType.deAcc:
      return '감속';
    case ExpType.uniSpeed:
      return '등속';
  }
}


class ExpEntity {
  ExpType expType;
  double zoneWidth;
  double zonePositionX;
  SpeedType speed;

  ExpEntity({required this.expType, required this.zoneWidth, required this.zonePositionX, required this.speed});

  ExpEntity.fromJson(Map<String, dynamic> json)
    :  expType = json['exp_type'],
      zoneWidth = json['zone_width'],
      zonePositionX = json['zone_position_x'],
      speed = json['speed'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp_type'] = expType;
    data['zone_width'] = zoneWidth;
    data['zone_position_x'] = zonePositionX;
    data['speed'] = speed;
    return data;
  }
}

enum ErrorType {
  early,
  late,
  miss,
  no_error_success
}

class ExpResultEntity{
  ExpEntity expEntity;
  bool success;
  double timingAccuracy;
  ErrorType errorType;

  ExpResultEntity({required this.expEntity, required this.success, required this.timingAccuracy, required this.errorType});

  ExpResultEntity.fromJson(Map<String, dynamic> json)
      : expEntity = json['exp_entity'],
        success = json['success'],
        timingAccuracy = json['timing_accuracy'],
        errorType = json['error_type'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp_entity'] = expEntity;
    data['success'] = success;
    data['timing_accuracy'] = timingAccuracy;
    data['error_type'] = errorType;
    return data;
  }
}