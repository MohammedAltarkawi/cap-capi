namespace com.altarkawi.CAPI;


entity ExternalData {
  key tadirObject             : String;
      tadirObjName            : String;
      objectType              : String;
      objectKey               : String;
      softwareComponent       : String;
      applicationComponent    : String;
      state                   : String;
      successorClassification : String;
      successors              : Composition of many Successors
                                  on successors.parent = $self;
}

entity Successors {
  key parent       : Association to ExternalData;
      tadirObject  : String;
      tadirObjName : String;
      objectType   : String;
      objectKey    : String;
}
