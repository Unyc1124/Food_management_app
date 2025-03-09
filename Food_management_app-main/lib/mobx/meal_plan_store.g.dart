// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealPlanStore on _MealPlanStoreBase, Store {
  late final _$mealPlansAtom =
      Atom(name: '_MealPlanStoreBase.mealPlans', context: context);

  @override
  ObservableList<MealPlan> get mealPlans {
    _$mealPlansAtom.reportRead();
    return super.mealPlans;
  }

  @override
  set mealPlans(ObservableList<MealPlan> value) {
    _$mealPlansAtom.reportWrite(value, super.mealPlans, () {
      super.mealPlans = value;
    });
  }

  late final _$selectedFrequencyAtom =
      Atom(name: '_MealPlanStoreBase.selectedFrequency', context: context);

  @override
  String get selectedFrequency {
    _$selectedFrequencyAtom.reportRead();
    return super.selectedFrequency;
  }

  @override
  set selectedFrequency(String value) {
    _$selectedFrequencyAtom.reportWrite(value, super.selectedFrequency, () {
      super.selectedFrequency = value;
    });
  }

  late final _$saveMealPlansToSharedPreferencesAsyncAction = AsyncAction(
      '_MealPlanStoreBase.saveMealPlansToSharedPreferences',
      context: context);

  @override
  Future<void> saveMealPlansToSharedPreferences() {
    return _$saveMealPlansToSharedPreferencesAsyncAction
        .run(() => super.saveMealPlansToSharedPreferences());
  }

  late final _$loadMealPlansFromSharedPreferencesAsyncAction = AsyncAction(
      '_MealPlanStoreBase.loadMealPlansFromSharedPreferences',
      context: context);

  @override
  Future<void> loadMealPlansFromSharedPreferences() {
    return _$loadMealPlansFromSharedPreferencesAsyncAction
        .run(() => super.loadMealPlansFromSharedPreferences());
  }

  late final _$addMealPlanAsyncAction =
      AsyncAction('_MealPlanStoreBase.addMealPlan', context: context);

  @override
  Future<void> addMealPlan(MealPlan plan) {
    return _$addMealPlanAsyncAction.run(() => super.addMealPlan(plan));
  }

  late final _$removeMealPlanAsyncAction =
      AsyncAction('_MealPlanStoreBase.removeMealPlan', context: context);

  @override
  Future<void> removeMealPlan(String id) {
    return _$removeMealPlanAsyncAction.run(() => super.removeMealPlan(id));
  }

  late final _$_MealPlanStoreBaseActionController =
      ActionController(name: '_MealPlanStoreBase', context: context);

  @override
  void setFrequency(String frequency) {
    final _$actionInfo = _$_MealPlanStoreBaseActionController.startAction(
        name: '_MealPlanStoreBase.setFrequency');
    try {
      return super.setFrequency(frequency);
    } finally {
      _$_MealPlanStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mealPlans: ${mealPlans},
selectedFrequency: ${selectedFrequency}
    ''';
  }
}
