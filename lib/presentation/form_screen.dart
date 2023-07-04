import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/domain/cubit/tile_cubit.dart';
import 'package:maps/presentation/tile_screen.dart';
import 'package:maps/presentation/widgets/app_error_dialog.dart';
import 'package:maps/presentation/widgets/app_text_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _cubit = TileCubit();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form'),
          backgroundColor: Colors.cyan,
        ),
        body: BlocListener(
          bloc: _cubit,
          listener: (context, state) {
            if (state is TileErrorState) {
              AppErrorDialog.get(context, state.errorText);
            } else if (state is TileReadyState) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReadyContent(tileInfo: state.tileInfo)),
              );
            }
          },
          child: _Body(
            onCalculate: (latitude, longitude, zoom) => _cubit.calculate(
              latitude: latitude,
              longitude: longitude,
              zoom: zoom,
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final Function(double latitude, double longitude, int zoom) onCalculate;

  const _Body({
    Key? key,
    required this.onCalculate,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final longitudeController = TextEditingController();
  final latitudeController = TextEditingController();
  final zoomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
        child: Column(
          children: [
            AppTextField(
              controller: latitudeController,
              hintText: 'Latitude',
              title: 'Введите широту в десятичном формате',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: longitudeController,
              hintText: 'Longitude',
              title: 'Введите долготу в десятичном формате',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: zoomController,
              hintText: 'Zoom',
              title: 'Введите приближение карты от 1 до 20',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле обязательно';
                } else if (int.parse(value) > 20) {
                  return 'Неверное приближение (1 - 20)';
                }
                return null;
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onCalculate(
                    double.parse(latitudeController.text),
                    double.parse(longitudeController.text),
                    int.parse(zoomController.text),
                  );
                }
              },
              child: const Text('Рассчитать'),
            ),
          ],
        ),
      ),
    );
  }
}
