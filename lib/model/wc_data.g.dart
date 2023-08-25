// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WCData on WCDataBase, Store {
  Computed<bool>? _$isPairingDetailAvailableComputed;

  @override
  bool get isPairingDetailAvailable => (_$isPairingDetailAvailableComputed ??=
          Computed<bool>(() => super.isPairingDetailAvailable,
              name: 'WCDataBase.isPairingDetailAvailable'))
      .value;

  late final _$uriAtom = Atom(name: 'WCDataBase.uri', context: context);

  @override
  String? get uri {
    _$uriAtom.reportRead();
    return super.uri;
  }

  @override
  set uri(String? value) {
    _$uriAtom.reportWrite(value, super.uri, () {
      super.uri = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'WCDataBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pairingInfoAtom =
      Atom(name: 'WCDataBase.pairingInfo', context: context);

  @override
  PairingInfo? get pairingInfo {
    _$pairingInfoAtom.reportRead();
    return super.pairingInfo;
  }

  @override
  set pairingInfo(PairingInfo? value) {
    _$pairingInfoAtom.reportWrite(value, super.pairingInfo, () {
      super.pairingInfo = value;
    });
  }

  late final _$pairConnectionAsyncAction =
      AsyncAction('WCDataBase.pairConnection', context: context);

  @override
  Future<void> pairConnection() {
    return _$pairConnectionAsyncAction.run(() => super.pairConnection());
  }

  late final _$clearAsyncAction =
      AsyncAction('WCDataBase.clear', context: context);

  @override
  Future<void> clear() {
    return _$clearAsyncAction.run(() => super.clear());
  }

  @override
  String toString() {
    return '''
uri: ${uri},
isLoading: ${isLoading},
pairingInfo: ${pairingInfo},
isPairingDetailAvailable: ${isPairingDetailAvailable}
    ''';
  }
}
