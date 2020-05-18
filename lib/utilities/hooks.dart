import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

STATE useBlocListener<BLOC extends Bloc, STATE>({Bloc<Object, STATE> bloc}) {
  final context = useContext();
  // ignore: close_sinks
  final blocObj = bloc ?? BlocProvider.of<BLOC>(context);

  final state = useMemoized(() => blocObj.skip(1), [blocObj.state]);
  return useStream(state, initialData: blocObj.state).data;
}

PageController usePageController({
  int initialPage = 0,
  bool keepPage = true,
  double viewportFraction = 1.0,
}) =>
    Hook.use(PageControllerHook(
      initialPage: initialPage,
      keepPage: keepPage,
      viewportFraction: viewportFraction,
    ));

class PageControllerHook extends Hook<PageController> {
  final int initialPage;
  final bool keepPage;
  final double viewportFraction;

  const PageControllerHook({
    this.initialPage = 0,
    this.keepPage = true,
    this.viewportFraction = 1.0,
  });

  @override
  HookState<PageController, Hook<PageController>> createState() =>
      _PageControllerHookState();
}

class _PageControllerHookState
    extends HookState<PageController, PageControllerHook> {
  PageController _pageController;

  @override
  PageController build(BuildContext context) {
    return _pageController ??= PageController(
      initialPage: hook.initialPage,
      keepPage: hook.keepPage,
      viewportFraction: hook.viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
