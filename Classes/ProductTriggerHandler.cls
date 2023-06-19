public with sharing class ProductTriggerHandler {
    List<Product2> oldRecords {get; set;}
    List<Product2> newRecords {get; set;}
    Map<Id, Product2> oldMap {get; set;}
    Map<Id, Product2> newMap {get; set;}

    public ProductTriggerHandler(List<Product2> oldRecords, List<Product2> newRecords, Map<Id, Product2> oldMap, Map<Id, Product2> newMap) {
        this.oldRecords = oldRecords;
        this.newRecords = newRecords;
        this.oldMap = oldMap;
        this.newMap = newMap;   
    }

    public void afterInsert() {
        ProductHelper.insertPricebookEntry(this.newRecords);
    }
}