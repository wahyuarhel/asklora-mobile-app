import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/utils.dart';
import '../../bloc/tab_screen_bloc.dart';
import '../../lora_gpt/bloc/lora_gpt_bloc.dart';
import '../../lora_gpt/presentation/lora_ai_screen.dart';
import '../../lora_gpt/repository/lora_gpt_repository.dart';

class AiOverlay extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  final bool enableSliding;

  const AiOverlay(
      {required this.maxHeight,
      required this.maxWidth,
      super.key,
      this.enableSliding = false});

  @override
  State<AiOverlay> createState() => _AiOverlayState();
}

class _AiOverlayState extends State<AiOverlay> with TickerProviderStateMixin {
  double _drawerBottom = double.infinity;
  Animation<double>? _animation;
  AnimationController? _controller;
  final Duration openAndCloseAnimationDuration =
      const Duration(milliseconds: 250);
  final Duration dragAnimationDuration = const Duration(milliseconds: 100);

  @override
  void dispose() {
    if (_animation != null) {
      _animation!.removeListener(() {});
    }
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    _drawerBottom = widget.maxHeight;
    super.initState();
  }

  bool _backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.read<TabScreenBloc>().add(const OnAiOverlayClick());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoraGptBloc(
          loraGptRepository: LoraGptRepository(),
          sharedPreference: SharedPreference())
        ..add(const OnLoraOpened()),
      child: BlocListener<TabScreenBloc, TabScreenState>(
        listenWhen: (previous, current) =>
            previous.aiPageSelected != current.aiPageSelected,
        listener: (context, state) => state.aiPageSelected
            ? _openAiOverlay(context)
            : _closeAiOverlay(context),
        child: Positioned(
          width: widget.maxWidth,
          height: widget.maxHeight,
          top: _drawerBottom,
          child: widget.enableSliding
              ? GestureDetector(
                  onPanDown: _onPanDown,
                  onPanEnd: _onPanEnd,
                  onPanUpdate: _onPanUpdate,
                  child: const LoraAiScreen(),
                )
              : const LoraAiScreen(),
        ),
      ),
    );
  }

  void _openAiOverlay(BuildContext context) {
    BackButtonInterceptor.add(_backButtonInterceptor);
    context.read<LoraGptBloc>().add(const FetchIntros());
    _controller = AnimationController(
        duration: openAndCloseAnimationDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {
          _drawerBottom =
              widget.maxHeight - _animation!.value * widget.maxHeight;
        });
      });
    _controller!.forward();
  }

  void _closeAiOverlay(BuildContext context) {
    BackButtonInterceptor.remove(_backButtonInterceptor);
    closeKeyboard();
    context.read<LoraGptBloc>().add(const OnAiOverlayClose());
    final double startingPoint = _drawerBottom;
    _controller = AnimationController(
        duration: openAndCloseAnimationDuration, vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller!)
      ..addListener(() {
        setState(() {
          _drawerBottom = widget.maxHeight -
              _animation!.value * (widget.maxHeight - startingPoint);
        });

        ///do something on close animation ends
        if (_animation!.value == 0) {
          _onClosed();
        }
      });
    _controller!.forward();
  }

  void _onDragExceedHalfOfScreen() {
    ///animation will pull down to bottom (close)
    final double startingPoint = _drawerBottom;
    _controller =
        AnimationController(duration: dragAnimationDuration, vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller!)
      ..addListener(() {
        setState(() {
          _drawerBottom = widget.maxHeight -
              _animation!.value * (widget.maxHeight - startingPoint);
        });

        ///do something on close animation ends
        if (_animation!.value == 0) {
          _onClosed();
        }
      });
    _controller!.forward();
  }

  void _onDragBelowHalfOfScreen() {
    ///animation will pull up to top
    final double startingPoint = _drawerBottom;
    _controller =
        AnimationController(duration: dragAnimationDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {
          _drawerBottom = startingPoint - startingPoint * _animation!.value;
        });
      });
    _controller!.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    ///update position on drag
    setState(() {
      _drawerBottom += details.delta.dy;
    });
  }

  void _onPanDown(DragDownDetails dragEndDetails) {
    ///dismiss keyboard on user tap down background
    closeKeyboard();
  }

  void _onPanEnd(DragEndDetails dragEndDetails) {
    ///do animation on drag release based on current position
    if (_drawerBottom >= widget.maxHeight / 2) {
      _onDragExceedHalfOfScreen();
    } else {
      _onDragBelowHalfOfScreen();
    }
  }

  void _onClosed() {
    ///do something on animation closed
  }
}
