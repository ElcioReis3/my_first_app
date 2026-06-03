import 'package:flutter/material.dart';
import 'package:my_first_app/models/candidate.dart';

class CandidateProvider extends ChangeNotifier {
  final List<Candidate> _candidates = Candidate.candidates();

  List<Candidate> get candidates => List.unmodifiable(_candidates);

  void addCandidate(Candidate candidate) {
    _candidates.add(candidate);
    notifyListeners();
  }

  void updateCandidate(int index, Candidate updated) {
    _candidates[index] = updated;
    notifyListeners();
  }

  void removeCandidate(int index) {
    _candidates.removeAt(index);
    notifyListeners();
  }
}
