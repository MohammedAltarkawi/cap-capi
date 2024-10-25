using com.altarkawi.CAPI as my from '../db/schema';

service CatalogService {
    @readonly
    entity API2022 as
        projection on my.ExternalData {
            tadirObject,
            tadirObjName,
            objectType,
            objectKey,
            softwareComponent,
            applicationComponent,
            state,
            successorClassification,
            successors
        };


}
