@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void testInsertOrUpdateOperation() {
        // Create test data using Test Data Factory
        Account testAccount = TestDatafactory.createTestAccount('1234567890');
        Contact testContact = TestDatafactory.createTestContact(testAccount.Id, '1234567890');
        
        // Update the phone number of the account
        testAccount.Phone = '0987654321';
        Test.startTest();
        update testAccount;
        Test.stopTest();
        
        // Query the updated contact
        Contact updatedContact = [SELECT Id, Phone FROM Contact WHERE Id = :testContact.Id];
        
        // Assert that the contact's phone number was updated correctly
        System.assertEquals('0987654321', updatedContact.Phone, 'The contact phone number should match the updated account phone number.');
    }
}