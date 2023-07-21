part of 'cycling_bloc.dart';

enum Packages { minutes30, minutes60, minutes120, day1 }

class CyclingState extends Equatable {
  final Packages currentPackage;

  const CyclingState._({this.currentPackage = Packages.minutes120});
  const CyclingState.initial() : this._();
  const CyclingState.minutes30() : this._(currentPackage: Packages.minutes30);
  const CyclingState.minutes60() : this._(currentPackage: Packages.minutes60);
  const CyclingState.minutes120() : this._();
  const CyclingState.day1() : this._(currentPackage: Packages.day1);

  @override
  List<Object?> get props => [currentPackage];
}
