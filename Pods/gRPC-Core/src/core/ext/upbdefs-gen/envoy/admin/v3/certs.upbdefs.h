/* This file was generated by upb_generator from the input file:
 *
 *     envoy/admin/v3/certs.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#ifndef ENVOY_ADMIN_V3_CERTS_PROTO_UPBDEFS_H_
#define ENVOY_ADMIN_V3_CERTS_PROTO_UPBDEFS_H_

#include "upb/reflection/def.h"
#include "upb/reflection/internal/def_pool.h"

#include "upb/port/def.inc" // Must be last.
#ifdef __cplusplus
extern "C" {
#endif

extern _upb_DefPool_Init envoy_admin_v3_certs_proto_upbdefinit;

UPB_INLINE const upb_MessageDef *envoy_admin_v3_Certificates_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_admin_v3_certs_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.admin.v3.Certificates");
}

UPB_INLINE const upb_MessageDef *envoy_admin_v3_Certificate_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_admin_v3_certs_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.admin.v3.Certificate");
}

UPB_INLINE const upb_MessageDef *envoy_admin_v3_CertificateDetails_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_admin_v3_certs_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.admin.v3.CertificateDetails");
}

UPB_INLINE const upb_MessageDef *envoy_admin_v3_CertificateDetails_OcspDetails_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_admin_v3_certs_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.admin.v3.CertificateDetails.OcspDetails");
}

UPB_INLINE const upb_MessageDef *envoy_admin_v3_SubjectAlternateName_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_admin_v3_certs_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.admin.v3.SubjectAlternateName");
}

#ifdef __cplusplus
}  /* extern "C" */
#endif

#include "upb/port/undef.inc"

#endif  /* ENVOY_ADMIN_V3_CERTS_PROTO_UPBDEFS_H_ */
