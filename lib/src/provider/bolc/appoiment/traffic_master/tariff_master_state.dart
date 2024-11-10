part of 'tariff_master_bloc.dart';

@freezed
class TariffMasterState with _$TariffMasterState {
  const factory TariffMasterState.initial() = _Initial;
  const factory TariffMasterState.loading() = _Loading;
  const factory TariffMasterState.success(List<TariffMaster> tariffMaster) =
      _Success;
  const factory TariffMasterState.error(String message) = _Error;
}
