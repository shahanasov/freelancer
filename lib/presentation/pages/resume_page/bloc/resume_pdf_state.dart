part of 'resume_pdf_bloc.dart';

 class ResumePdfState {}

final class ResumePdfInitial extends ResumePdfState {}
final class ResumeLoadingState extends ResumePdfState{}
final class ResumeLoaded extends ResumePdfState{
  final ResumeModel resume;

  ResumeLoaded({required this.resume});
}
final class ResumeEmpty extends ResumePdfState{}
