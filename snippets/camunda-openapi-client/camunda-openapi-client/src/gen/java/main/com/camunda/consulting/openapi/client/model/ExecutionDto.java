/*
 * Camunda BPM REST API
 * OpenApi Spec for Camunda BPM REST API.
 *
 * The version of the OpenAPI document: 7.13.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


package com.camunda.consulting.openapi.client.model;

import java.util.Objects;
import java.util.Arrays;
import com.google.gson.TypeAdapter;
import com.google.gson.annotations.JsonAdapter;
import com.google.gson.annotations.SerializedName;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.IOException;

/**
 * ExecutionDto
 */
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.JavaClientCodegen", date = "2020-07-14T01:59:23.608853+02:00[Europe/Berlin]")
public class ExecutionDto {
  public static final String SERIALIZED_NAME_ID = "id";
  @SerializedName(SERIALIZED_NAME_ID)
  private String id;

  public static final String SERIALIZED_NAME_PROCESS_INSTANCE_ID = "processInstanceId";
  @SerializedName(SERIALIZED_NAME_PROCESS_INSTANCE_ID)
  private String processInstanceId;

  public static final String SERIALIZED_NAME_ENDED = "ended";
  @SerializedName(SERIALIZED_NAME_ENDED)
  private Boolean ended;

  public static final String SERIALIZED_NAME_TENANT_ID = "tenantId";
  @SerializedName(SERIALIZED_NAME_TENANT_ID)
  private String tenantId;


  public ExecutionDto id(String id) {
    
    this.id = id;
    return this;
  }

   /**
   * The id of the Execution.
   * @return id
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "The id of the Execution.")

  public String getId() {
    return id;
  }


  public void setId(String id) {
    this.id = id;
  }


  public ExecutionDto processInstanceId(String processInstanceId) {
    
    this.processInstanceId = processInstanceId;
    return this;
  }

   /**
   * The id of the root of the execution tree representing the process instance.
   * @return processInstanceId
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "The id of the root of the execution tree representing the process instance.")

  public String getProcessInstanceId() {
    return processInstanceId;
  }


  public void setProcessInstanceId(String processInstanceId) {
    this.processInstanceId = processInstanceId;
  }


  public ExecutionDto ended(Boolean ended) {
    
    this.ended = ended;
    return this;
  }

   /**
   * Indicates if the execution is ended.
   * @return ended
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "Indicates if the execution is ended.")

  public Boolean getEnded() {
    return ended;
  }


  public void setEnded(Boolean ended) {
    this.ended = ended;
  }


  public ExecutionDto tenantId(String tenantId) {
    
    this.tenantId = tenantId;
    return this;
  }

   /**
   * The id of the tenant this execution belongs to. Can be &#x60;null&#x60; if the execution belongs to no single tenant.
   * @return tenantId
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "The id of the tenant this execution belongs to. Can be `null` if the execution belongs to no single tenant.")

  public String getTenantId() {
    return tenantId;
  }


  public void setTenantId(String tenantId) {
    this.tenantId = tenantId;
  }


  @Override
  public boolean equals(java.lang.Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    ExecutionDto executionDto = (ExecutionDto) o;
    return Objects.equals(this.id, executionDto.id) &&
        Objects.equals(this.processInstanceId, executionDto.processInstanceId) &&
        Objects.equals(this.ended, executionDto.ended) &&
        Objects.equals(this.tenantId, executionDto.tenantId);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, processInstanceId, ended, tenantId);
  }


  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class ExecutionDto {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    processInstanceId: ").append(toIndentedString(processInstanceId)).append("\n");
    sb.append("    ended: ").append(toIndentedString(ended)).append("\n");
    sb.append("    tenantId: ").append(toIndentedString(tenantId)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(java.lang.Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }

}
