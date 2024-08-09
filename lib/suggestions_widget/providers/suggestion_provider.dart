// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../constants/dummy_suggestion_data.dart';
// import '../../models/suggestion.dart';

// final suggestionProvider =
//     StateNotifierProvider<SuggestionNotifier, List<Suggestion>>((ref) {
//   return SuggestionNotifier();
// });

// class SuggestionNotifier extends StateNotifier<List<Suggestion>> {
//   SuggestionNotifier() : super(DummySuggestionData.suggestions);

//   DateTime _selectedDate = DateTime.now();

//   DateTime get selectedDate => _selectedDate;

//   void setDate(DateTime date) => _selectedDate = date;

//   List<Suggestion> get allSuggestions => state;

//   void add(Suggestion suggestion) {
//     state = [...state, suggestion];
//   }

//   void edit(Suggestion newSuggestion, Suggestion oldSuggestion) {
//     state = [
//       for (final s in state)
//         if (oldSuggestion == s) newSuggestion else s,
//     ];
//   }

//   void remove(Suggestion suggestion) {
//     state = [
//       for (final ev in state)
//         if (ev != suggestion) ev
//     ];
//   }
// }
