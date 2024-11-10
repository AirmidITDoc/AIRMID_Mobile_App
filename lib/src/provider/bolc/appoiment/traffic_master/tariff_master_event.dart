part of 'tariff_master_bloc.dart';

@freezed
class TariffMasterEvent with _$TariffMasterEvent {
  const factory TariffMasterEvent.started() = _Started;
}