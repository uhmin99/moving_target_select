import '../entity/exp_entity.dart';

// Experiment Types
enum SpeedType { slow, fast }

// Predefined Experiment Values
double TIMING_UNPRESSED = -1.0;

// Experiment Constants
int ballSpeedDuration = 800; // Total Duration of the Ball that controls the speed of the ball. In milliseconds
int freezePerTrialMilli = 300;

/*
Constants
타겟 등장 주기(P): 1250, 1800 ms
획득 구역 내 머무르는 시간(Wt): 80, 150 ms
획득 구역 도착 소요 시간(tc): 50, 150, 350 ms
*/
double targetAppearancePeriod_Short = 1250;
double targetAppearancePeriod_Long = 1800;

double zoneStayTime_Short = 80;
double zoneStayTime_Long = 150;

double zoneArrivalTime_Short = 50;
double zoneArrivalTime_Medium = 150;
double zoneArrivalTime_Long = 350;

int TRIAL_PER_EXP = 40;
int BreakTime = 20;  //in seconds

double accelerationRate = 50;
double deccelerationRate = 50;

double initialPosition = 200;
double initSpeepdAcc = 200;
double initSpeedDeAcc = 200;

// Experiment Types
List<ExpEntity> accExpList = [
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.acc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long),
];

List<ExpEntity> deAccExpList = [
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.deAcc, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long)
];

List<ExpEntity> uniSpeedExpList = [
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Short, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Short, zoneArrivalTime: zoneArrivalTime_Long),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Short),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Medium),
  ExpEntity(expType: ExpType.uniSpeed, targetAppearancePeriod: targetAppearancePeriod_Long, zoneStayTime: zoneStayTime_Long, zoneArrivalTime: zoneArrivalTime_Long)
];