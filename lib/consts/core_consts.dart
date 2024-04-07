import '../entity/exp_entity.dart';

// Constants
double ZoneWidthLarge = 200.0;
double ZoneWidthSmall = 100.0;

double ZonePositionClose = 400.0;
double ZonePositionFar = 550.0;

enum SpeedType { slow, fast }

double TIMING_UNPRESSED = -1.0;

// Experiment Types
List<ExpEntity> accExpList = [
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
];

List<ExpEntity> deAccExpList = [
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
];

List<ExpEntity> uniSpeedExpList = [
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, speed: SpeedType.fast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.slow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, speed: SpeedType.fast),
];