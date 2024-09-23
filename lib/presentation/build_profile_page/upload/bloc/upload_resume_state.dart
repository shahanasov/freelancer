part of 'upload_resume_bloc.dart';

 class UploadResumeState {}

final class UploadResumeInitial extends UploadResumeState {}
final class UploadingResumeState extends UploadResumeState{}
final class UploadedResume extends UploadResumeState{
  final ResumeModel? resumeModel;

  UploadedResume({required this.resumeModel});
}
final class ErrorUploadState extends UploadResumeState{}