package com.capgemini.wsb.service;

import com.capgemini.wsb.dto.AddressTO;
import com.capgemini.wsb.persistence.dao.AddressDao;
import com.capgemini.wsb.persistence.entity.AddressEntity;
import com.capgemini.wsb.service.impl.AddressServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
public class AddressServiceIntegrationTest {

    @Autowired
    private AddressServiceImpl addressService;

    @Autowired
    private AddressDao addressDao;

    private Long savedAddressId;

    @BeforeEach
    public void setup() {
        addressDao.deleteAll();
        AddressEntity addressEntity = new AddressEntity();
        addressEntity.setAddressLine1("Test Street");
        addressEntity.setCity("Test City");
        addressEntity.setPostalCode("12345");
        addressEntity = addressDao.save(addressEntity);
        savedAddressId = addressEntity.getId();
    }

    @Test
    public void testFindById() {
        AddressTO address = addressService.findById(savedAddressId);
        assertNotNull(address);
        assertEquals("Test Street", address.getAddressLine1());
    }

    @Test
    public void testAddAddress() {
        AddressTO addressTO = new AddressTO();
        addressTO.setAddressLine1("New Street");
        addressTO.setCity("New City");
        addressTO.setPostalCode("54321");
        AddressTO savedAddress = addressService.addAddress(addressTO);
        assertNotNull(savedAddress.getId());
        assertEquals("New Street", savedAddress.getAddressLine1());
    }

    @Test
    public void testUpdateAddress() {
        AddressTO addressTO = new AddressTO();
        addressTO.setId(savedAddressId);
        addressTO.setAddressLine1("Updated Street");
        addressTO.setCity("Updated City");
        addressTO.setPostalCode("67890");
        AddressTO updatedAddress = addressService.updateAddress(addressTO);
        assertEquals("Updated Street", updatedAddress.getAddressLine1());
    }

    @Test
    public void testRemoveAddress() {
        addressService.removeAddress(savedAddressId);
        AddressEntity deletedAddress = addressDao.findById(savedAddressId).orElse(null);
        assertNull(deletedAddress);
    }
}