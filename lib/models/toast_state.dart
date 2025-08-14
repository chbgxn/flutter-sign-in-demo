class ToastState {
  final String message;
  final bool isShow;

  ToastState({
    this.message = '', 
    this.isShow = false, 
  });

  ToastState copyWith({
    String? message,
    bool? isShow
  }){
    return ToastState(
      message: message ?? this.message,
      isShow: isShow ?? this.isShow
    );
  }
}

