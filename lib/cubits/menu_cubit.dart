import 'package:bloc/bloc.dart';
import 'package:canteen_mgmt_frontend/models/menu.dart';
import 'package:canteen_mgmt_frontend/services/menu_service.dart';
import 'package:get_it/get_it.dart';

class MenuCubit extends Cubit<List<Menu>> {
  final MenuService _menuService;

  MenuCubit()
      : _menuService = GetIt.I.get<MenuService>(),
        super([]) {
    refresh(null);
  }

  Future<void> refresh(String? menuDay) async =>
      emit(await _menuService.fetchMenus(menuDay: menuDay));
}
