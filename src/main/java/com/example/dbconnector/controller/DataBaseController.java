package com.example.dbconnector.controller;

import com.example.dbconnector.models.SqlRequest;
import com.example.dbconnector.models.StoreProcedureRequest;
import com.example.dbconnector.services.DatabaseService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/db")
public class DataBaseController {

    private final DatabaseService databaseService;

    @Autowired
    public DataBaseController(DatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    @PostMapping("/store-procedure/list")
    public ResponseEntity<List<Map<String, Object>>> callStoreProcedureList(@Valid @RequestBody StoreProcedureRequest request) throws SQLException {
        return ResponseEntity.ok(databaseService.executeStoredProcedure(request));
    }

    @PostMapping("/store-procedure/one")
    public ResponseEntity<List<Map<String, Object>>> callStoreProcedureOne(@Valid @RequestBody StoreProcedureRequest request) throws SQLException {
        return ResponseEntity.ok(databaseService.executeStoredProcedure(request));
    }

    @PostMapping("/sql-operation/list")
    public ResponseEntity<List<Map<String, Object>>> callSelectList(@Valid @RequestBody SqlRequest request) {
        return ResponseEntity.ok(databaseService.callSelectList(request));
    }

}
