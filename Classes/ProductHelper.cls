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

    public Static Set<String> getCurrencyList() {
 
        List<CurrencyType> currencyList =  [
            SELECT Id, IsoCode 
            FROM CurrencyType
        ];

        Set<String> currencyCodeSet = new Set<String>();
        for (CurrencyType currencyType : currencyList) {
            currencyCodeSet.add(currencyType.isoCode);
        }

        return currencyCodeSet;
    }

    public static List<PricebookEntry> createPriceBookEntry(List<Product2> productList, String pricebookId) {
        List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();
        Set<String> currencyCodeSet = getCurrencyList();

        for (String currencyCode : currencyCodeSet) {
            for (Product2 product : productList) { 
                PricebookEntry newPricebookEntry = new PricebookEntry (
                    Product2Id = product.Id,
                    Pricebook2Id = pricebookId,
                    UnitPrice = 0,
                    CurrencyIsoCode = currencyCode
                );
                
                pricebookEntryList.add(newPricebookEntry);
            }
        }
        
        return pricebookEntryList;
    }
}