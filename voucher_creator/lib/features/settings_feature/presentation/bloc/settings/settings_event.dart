part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SetSettingsEvent extends SettingsEvent {
  final SettingsModel settings;

  SetSettingsEvent(this.settings);
}

class GetSettingsEvent extends SettingsEvent {}
