abstract class SocialAppStates {}

class HomeInitialState extends SocialAppStates {}

class GetUserDataLoadingState extends SocialAppStates {}

class GetUserDataSuccessState extends SocialAppStates {}

class GetUserDataErrorState extends SocialAppStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class GetAllUserDataLoadingState extends SocialAppStates {}

class GetAllUserDataSuccessState extends SocialAppStates {}

class GetAllUserDataErrorState extends SocialAppStates {
  final String error;

  GetAllUserDataErrorState(this.error);
}

class GetPostDataLoadingState extends SocialAppStates {}

class GetPostDataSuccessState extends SocialAppStates {}

class GetPostDataErrorState extends SocialAppStates {
  final String error;

  GetPostDataErrorState(this.error);
}

class LikePostSuccessState extends SocialAppStates {}

class LikePostErrorState extends SocialAppStates {
  final String error;

  LikePostErrorState(this.error);
}
class CommentPostSuccessState extends SocialAppStates {}

class CommentPostErrorState extends SocialAppStates {
  final String error;

  CommentPostErrorState(this.error);
}

class SendEmailSuccessState extends SocialAppStates {}

class SendEmailErrorState extends SocialAppStates {
  final String error;

  SendEmailErrorState(this.error);
}

class BottomNavBarChangeState extends SocialAppStates {}

class PostPageSelectedState extends SocialAppStates {}

class SocialProfileImagePickedSuccessState extends SocialAppStates {}

class SocialProfileImagePickedErrorState extends SocialAppStates {}

class SocialUploadProfileImageLoadingState extends SocialAppStates {}

class SocialUploadProfileImageSuccessState extends SocialAppStates {}

class SocialUploadProfileImageErrorState extends SocialAppStates {}

class SocialCoverImagePickedSuccessState extends SocialAppStates {}

class SocialCoverImagePickedErrorState extends SocialAppStates {}

class SocialUploadCoverImageLoadingState extends SocialAppStates {}

class SocialUploadCoverImageSuccessState extends SocialAppStates {}

class SocialUploadCoverImageErrorState extends SocialAppStates {}

class SocialUpdateUserDataLoadingState extends SocialAppStates {}

class SocialUpdateUserDataErrorState extends SocialAppStates {}

class SocialCreatePostLoadingState extends SocialAppStates {}

class SocialCreatePostSuccessState extends SocialAppStates {}

class SocialCreatePostErrorState extends SocialAppStates {}

class SocialUploadPostImageSuccessState extends SocialAppStates {}

class SocialUploadPostImageErrorState extends SocialAppStates {}

class SocialremovePickedPostImageSuccessState extends SocialAppStates {}

class SendMessageSuccessState extends SocialAppStates {}

class SendMessageErrorState extends SocialAppStates {
  final String error;

  SendMessageErrorState(this.error);
}

class ReciveMessageSuccessState extends SocialAppStates {}