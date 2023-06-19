public with sharing class ProductHelper {
    public static void insertPricebookEntry (List<Product2> productList) {

        String standardPricebookId = getDefaultPricebook();
        List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();

        if(String.isNotBlank(standardPricebookId))
            pricebookEntryList = createPriceBookEntry(productList, standardPricebookId);

        if (!pricebookEntryList.isEmpty())
            insert pricebookEntryList;
    }

    public static String getDefaultPricebook() {
        String defaultPricebookId = '';

        List<Pricebook2> pricebookList = [
            SELECT Id 
            FROM Pricebook2 
            WHERE IsStandard = true
            LIMIT 1
        ];

        if (!pricebookList.isEmpty()) 
            defaultPricebookId = pricebookList[0].Id;
            
        return defaultPricebookId;
    }

    public Static List<Pricebook2> getPricebookCurrencyList() {
        List<Pricebook2> pricebookList =  [
            SELECT Id, CurrencyIsoCode 
            FROM Pricebook2
        ];

        return pricebookList;
    }

    public static List<PricebookEntry> createPriceBookEntry(List<Product2> productList, String pricebookId) {
        List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();
        List<Pricebook2> pricebookList = getPricebookCurrencyList();

        for (Pricebook2 pricebook : pricebookList) {
            for (Product2 product : productList) { 
                PricebookEntry newPricebookEntry = new PricebookEntry (
                    Product2Id = product.Id,
                    Pricebook2Id = pricebookId,
                    UnitPrice = 0,
                    CurrencyIsoCode = pricebook.CurrencyIsoCode
                );
                
                pricebookEntryList.add(newPricebookEntry);
            }
        }
        
        return pricebookEntryList;
    }
}