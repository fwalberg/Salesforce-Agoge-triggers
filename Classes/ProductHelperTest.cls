@isTest
public with sharing class ProductHelperTest {

    @TestSetup
    static void makeData(){
        try {
            TestFactorySObject sobjectFactory = TestFactorySObject.getInstance();

            Pricebook2 defaultPricebook = new Pricebook2(
            	Id = Test.getStandardPricebookId(),
                IsActive = true
            );
            update defaultPricebook;

            List<Product2> productList = new List<Product2>();

            productList.add((Product2)sobjectFactory.createSObject(new Product2()));
            productList.add((Product2)sobjectFactory.createSObject(new Product2()));
            productList.add((Product2)sobjectFactory.createSObject(new Product2()));
            productList.add((Product2)sobjectFactory.createSObject(new Product2()));
            productList.add((Product2)sobjectFactory.createSObject(new Product2()));

            insert productList;    
        } 

        catch (DmlException e) {
            String errorMessage = e.getMessage();
        } 
    }

    // Verifica se foi criado um pricebook2 para cada produto inserido no método MakeData.
    // Cenário de Sucesso
    @isTest
    public static void checkPricebookCreated() {
        Boolean wasCreatedPricebook = false;

        try {
            List<Product2> productList = [
                SELECT Id 
                FROM Product2 
                WHERE Name LIKE 'TA35'
            ];

            Set<String> productIdSet = new Set<String>();
            for (Product2 product : productList) {
                productIdSet.add(product.Id);
            }

            List<PricebookEntry> pricebookEntryList = [
                SELECT Product2Id 
                FROM PricebookEntry 
                WHERE Product2Id IN :productIdSet 
                AND Pricebook2.isStandard = true 
            ];

            Set<String> pricebookIdSet = new Set<String>();
            for (PricebookEntry pricebook : pricebookEntryList) {
                pricebookIdSet.add(pricebook.Product2Id);
            }

            System.debug('Product: ' + productList);
            System.debug('PriceEntry: ' + pricebookEntryList);

            wasCreatedPricebook = productIdSet.equals(pricebookIdSet) ? true : false;

        } catch(Exception e) {
            wasCreatedPricebook = false;
            String errorMessage = e.getMessage();
        }

        System.assertEquals(true, wasCreatedPricebook);
    }

    // Verifica se foi criado um pricebook2 para cada produto inserido no método MakeData.
    // Cenário de Erro
    @isTest
    public static void checkPricebookCreatedFail() {
        Boolean wasCreatedPricebook = false;

        try {
            List<Product2> productList = [
                SELECT Id 
                FROM Product2 
                WHERE Name LIKE 'TA35%'
            ];

            Set<Id> productIdSet = new Set<Id>();
            for (Product2 product : productList) {
                productIdSet.add(product.Id);
            }

            List<PricebookEntry> pricebookEntryList = [
                SELECT Product2Id 
                FROM PricebookEntry 
                WHERE Product2Id IN :productIdSet
                AND Pricebook2.isStandard = true
                AND UnitPrice = 0
                LIMIT 3
            ];

            Set<String> pricebookIdSet = new Set<String>();
            for (PricebookEntry pricebook : pricebookEntryList) {
                pricebookIdSet.add(pricebook.Product2Id);
            }

            wasCreatedPricebook = productIdSet.equals(pricebookIdSet) ? true : false;

        } catch(Exception e) {
            wasCreatedPricebook = false;
            String errorMessage = e.getMessage();
        }

        System.assertEquals(false, wasCreatedPricebook);
    }
}