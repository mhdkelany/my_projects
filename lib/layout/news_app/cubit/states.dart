abstract class NewsStates{}
class InitialNewsState extends NewsStates{}
class ChangeBottomNavState extends NewsStates{}
class GetBusinessDataState extends NewsStates{}
class GetBusinessDataLoadingState extends NewsStates{}
class GetBusinessDataErrorState extends NewsStates{ String error; GetBusinessDataErrorState(this.error);}
class GetSportsDataState extends NewsStates{}
class GetSportsDataLoadingState extends NewsStates{}
class GetSportsDataErrorState extends NewsStates{ String error; GetSportsDataErrorState(this.error);}
class GetScienceDataState extends NewsStates{}
class GetScienceDataLoadingState extends NewsStates{}
class GetScienceDataErrorState extends NewsStates{ String error; GetScienceDataErrorState(this.error);}
class GetSearchDataState extends NewsStates{}
class GetSearchDataLoadingState extends NewsStates{}
class GetSearchDataErrorState extends NewsStates{ String error; GetSearchDataErrorState(this.error);}
