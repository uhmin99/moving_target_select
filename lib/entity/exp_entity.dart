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

// Constants
// 타겟 등장 주기(P): 1250, 1800 ms
// 획득 구역 내 머무르는 시간(Wt): 80, 150 ms
// 획득 구역 도착 소요 시간(tc): 50, 150, 350 ms
// double targetAppearancePeriod_Short = 1250;
// double targetAppearancePeriod_Long = 1800;

// double targetStayTime_Short = 80;
// double targetStayTime_Long = 150;

// double targetArrivalTime_Short = 50;
// double targetArrivalTime_Medium = 150;
// double targetArrivalTime_Long = 350;


class ExpEntity {
  ExpType expType;
  double targetAppearancePeriod;
  double zoneStayTime;
  double zoneArrivalTime;

  ExpEntity({required this.expType, required this.targetAppearancePeriod, required this.zoneStayTime, required this.zoneArrivalTime});

  ExpEntity.fromJson(Map<String, dynamic> json)
    :  expType = json['exp_type'],
      targetAppearancePeriod = json['targetAppearancePeriod'],
      zoneStayTime = json['zoneStayTime'],
      zoneArrivalTime = json['zoneArrivalTime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp_type'] = expType;
    data['targetAppearancePeriod'] = targetAppearancePeriod;
    data['zoneStayTime'] = zoneStayTime;
    data['zoneArrivalTime'] = zoneArrivalTime;
    return data;
  }
}

enum ErrorType {
  early,
  late,
  no_press,
  no_error_success
}

String errorTypeToString(ErrorType errorType) {
  switch(errorType) {
    case ErrorType.early:
      return '조기';
    case ErrorType.late:
      return '지연';
    case ErrorType.no_press:
      return '미입력';
    case ErrorType.no_error_success:
      return '오류없음';
  }
}

class ExpResultEntity{
  ExpEntity expEntity;
  int trialNum;
  bool success;
  double timingAccuracy;
  ErrorType errorType;
  DateTime? targetAppearanceTime;
  DateTime? zoneArrivalTime;
  DateTime? zoneLeaveTime;
  DateTime? buttonPressTime;

  ExpResultEntity({
    required this.expEntity,
    required this.trialNum,
    required this.success,
    required this.timingAccuracy,
    required this.errorType,
    required this.targetAppearanceTime,
    required this.zoneArrivalTime,
    required this.zoneLeaveTime,
    required this.buttonPressTime
  });

  ExpResultEntity.fromJson(Map<String, dynamic> json)
      : expEntity = json['exp_entity'],
        trialNum = json['trial_num'],
        success = json['success'],
        timingAccuracy = json['timing_accuracy'],
        errorType = json['error_type'],
        targetAppearanceTime = json['targetAppearanceTime'],
        zoneArrivalTime = json['zoneArrivalTime'],
        zoneLeaveTime = json['zoneLeaveTime'],
        buttonPressTime = json['buttonPressTime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp_entity'] = expEntity;
    data['trial_num'] = trialNum;
    data['success'] = success;
    data['timing_accuracy'] = timingAccuracy;
    data['error_type'] = errorType;
    data['targetAppearanceTime'] = targetAppearanceTime??'측정안됨';
    data['zoneArrivalTime'] = zoneArrivalTime??'측정안됨';
    data['zoneLeaveTime'] = zoneLeaveTime??'측정안됨';
    data['buttonPressTime'] = buttonPressTime??'측정안됨';

    return data;
  }
}