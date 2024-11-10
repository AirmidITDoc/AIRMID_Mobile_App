class Api {
  // static const String _baseUrl = "http://192.168.2.100:8085/";
  static const String baseUrl = "https://117.247.89.198:8087/";

  // login
  static const String login = "${baseUrl}api/Login/token";
  static const String apiBaseUrl = '${baseUrl}api/Generic/GetByProc?procName=';
  // static const String admittedPatient = "Rtrv_AdmisionList_NursingList";
  static const String admittedPatient = "m_APP_ADMISSION_LIST";

  // op List
  static const String opdList = "m_APP_OP_VISIT_LIST";
  static const String dashboardCount = 'm_DASH_IP_ADMISSION_DISCHARGE_COUNT';
  static const String prefixList = 'm_Rtrv_PrefixListForCombo';
  static const String refDoctor = 'm_Rtrv_RefDoctorListForCombo';
  static const String pationSummryBiling = 'm_APP_BILL_OP_IP_LIST';
  static const String pationSummryPathalogy = 'm_APP_PATHOLOGY_OP_IP_LIST';
  static const String getDepartMent = 'RetrieveDepartmentMasterForCombo';
  static const String getDoctorName =
      'Retrieve_DoctorWithDepartMasterForCombo_Conditional';
  static const String getGender = "Retrieve_SexMasterForCombo_Conditional";
  static const String patientType = "RetrievePatientTypeMasterForCombo";
  static const String getTraffict = "RetrieveTariffMasterForCombo";

  static const String pationSummryRadilogy = "m_APP_RADIOLOGY_OP_IP_LIST";
  static const String bilingDetails = "m_APP_VIEW_BILL_DET";

  // hospital Dashboard
  static const String hospitalSummry = "m_APP_DASH_HOSPITAL_SUMMARY";
  static const String hospitalPharmacySummry =
      "m_APP_DASH_PHAR_COLLECTION_SUMMARY";
  static const String storeList = "m_Rtrv_PharStoreNameList";
  static const String wardList = "m_Rtrv_AdmittedWardList";
  static const String admittedDoctor = "m_Rtrv_AdmittedDoctorList";

  // apointment
  static const String addAppointment = "api/OutPatient/AppointmentInsert";
  static const String patientRegisterList = "m_Rtrv_PatientRegistrationList";
  static const String registerAppoinment =
      "api/OutPatient/AppointmentVisitUpdate";
}
