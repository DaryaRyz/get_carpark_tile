import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/domain/models/tile_info.dart';
import 'package:maps/domain/routers.dart';

class TileCubit extends Cubit<TileCubitState> {
  TileCubit() : super(TileInitialState());

  void calculate({
    required double latitude,
    required double longitude,
    required int zoom,
  }) {
    try {
      const e = 0.0818191908426;
      final beta = (pi * latitude) / 180;
      final phi = (1 - e * sin(beta)) / (1 + e * sin(beta));
      final pho = pow(2, (zoom + 8)) / 2;
      final theta = tan(pi / 4 + beta / 2) * pow(phi, e / 2);
      final x = pho * (1 + longitude / 180) ~/ 256;
      final y = pho * (1 - log(theta) / pi) ~/ 256;
      emit(
        TileReadyState(
          TileInfo(
            x: x,
            y: y,
            zoom: zoom,
            tileUrl: Routers.getTile(x: x, y: y, zoom: zoom),
          ),
        ),
      );
    } catch (e) {
      emit(TileErrorState('Произошла ошибка при расчете координат'));
    }
  }
}

abstract class TileCubitState {}

class TileInitialState extends TileCubitState {}

class TileReadyState extends TileCubitState {
  final TileInfo tileInfo;

  TileReadyState(this.tileInfo);
}

class TileErrorState extends TileCubitState {
  final String errorText;

  TileErrorState(this.errorText);
}
