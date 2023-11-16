package com.example.dbconnector.services;

import com.example.dbconnector.models.SqlRequest;
import com.example.dbconnector.models.StoreProcedureRequest;
import com.example.dbconnector.utils.mappers.ResultSetMappers;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.*;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Servicio para interactuar con la base de datos.
 */
@Service
public class DatabaseService {

    private static final Logger logger = LoggerFactory.getLogger(DatabaseService.class);

    private final DataSource dataSource;

    @Autowired
    public DatabaseService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private CallableStatement prepareCallableStatement(@NotNull Connection conn, @NotNull StoreProcedureRequest request) throws SQLException {
        SqlParameterSource namedParameters = new MapSqlParameterSource(request.getParameters());
        ParsedSql parsedSqlObj = NamedParameterUtils.parseSqlStatement(request.getSql());
        String parsedSql = NamedParameterUtils.substituteNamedParameters(parsedSqlObj, namedParameters);
        Object[] values = NamedParameterUtils.buildValueArray(parsedSqlObj, namedParameters, null);
        CallableStatement callableStatement = conn.prepareCall(parsedSql);
        for (int i = 0; i < values.length; i++) {
            callableStatement.setObject(i + 1, values[i]);
        }
        return callableStatement;
    }

    public List<Map<String, Object>> executeStoredProcedure(@NotNull StoreProcedureRequest request) throws SQLException {

        System.out.println(request.getSql());

        List<Map<String, Object>> results = new ArrayList<>();
        try (Connection conn = dataSource.getConnection(); CallableStatement callableStatement = prepareCallableStatement(conn, request); ResultSet rs = callableStatement.executeQuery()) {
            while (rs.next()) {
                if (request.hasIndexColumnNames()) {
                    results.add(ResultSetMappers.mapColumnWithList(rs, request.getIndexColumnNames()));
                } else if (request.hasPathCoulumnNames()) {
                    results.add(ResultSetMappers.mapColumnsWithPath(rs, request.getPathColumnNames()));
                } else {
                    results.add(ResultSetMappers.autoMap(rs));
                }
            }
        } catch (SQLException e) {
            var message = "Error al procesar: " + request.getSql();
            logger.error(message, e);
            throw new SQLException(message, e);
        }
        return results;
    }


    public List<Map<String, Object>> callSelectList(@NotNull SqlRequest request) {
        var namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
        var params = new MapSqlParameterSource(request.getParameters());
        return namedParameterJdbcTemplate.queryForList(request.getSql(), params);
    }

}
