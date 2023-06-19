trigger ProductTrigger on Product2 (after insert) {
    ProductTriggerHandler handler = new ProductTriggerHandler(
        Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap
    );

    switch on Trigger.operationType {
        when AFTER_INSERT {
            handler.afterInsert();
        }
    }
}