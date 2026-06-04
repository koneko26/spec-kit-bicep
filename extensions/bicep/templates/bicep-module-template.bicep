// =============================================================================
// Bicep module template (best-practice skeleton)
// Reference shape for modules under 600_build/modules/. Adapt per detailed design.
// =============================================================================

metadata name = 'module-name'
metadata description = 'What this module provisions.'

// ---- Parameters (use decorators; never hardcode secrets) --------------------

@description('Azure region for resources in this module.')
param location string = resourceGroup().location

@description('Common tags applied to every resource.')
param tags object = {}

@description('Naming prefix following the project convention, e.g. app-prod-jpe.')
@minLength(2)
param namePrefix string

@description('SKU/tier for the primary resource.')
@allowed([
  'Standard'
  'Premium'
])
param sku string = 'Standard'

@description('Secret values must be passed securely (Key Vault reference), never as plain defaults.')
@secure()
param adminSecret string = ''

// ---- Variables --------------------------------------------------------------

var resourceName = '${namePrefix}-001'

// ---- Resources --------------------------------------------------------------

// resource example 'Microsoft.Provider/type@2023-01-01' = {
//   name: resourceName
//   location: location
//   tags: tags
//   sku: { name: sku }
//   properties: {
//     // ...
//   }
// }

// ---- Outputs ----------------------------------------------------------------

@description('Resource id of the primary resource (for cross-module wiring).')
output resourceId string = '' // = example.id

@description('Resource name.')
output resourceName string = resourceName
