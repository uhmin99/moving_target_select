import '../entity/exp_entity.dart';

double ZoneWidthLarge = 200.0;
double ZoneWidthSmall = 100.0;

double ZonePositionClose = 400.0;
double ZonePositionFar = 600.0;

double InitSpeedSlow = 1.0;
double InitSpeedFast = 3.0;

List<ExpEntity> accExpList = [
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.acc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
];

List<ExpEntity> deAccExpList = [
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.deAcc, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
];

List<ExpEntity> uniSpeedExpList = [
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthLarge, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionClose, initSpeed: InitSpeedFast),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedSlow),
  ExpEntity(expType: ExpType.uniSpeed, zoneWidth: ZoneWidthSmall, zonePositionX: ZonePositionFar, initSpeed: InitSpeedFast),
];