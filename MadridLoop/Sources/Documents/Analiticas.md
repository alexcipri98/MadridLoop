# Resumen de eventos Firebase Analytics

Este documento describe los eventos personalizados que se envían desde la app a Firebase Analytics, indicando dónde se generan y qué parámetros incluyen.

---

## Eventos en LandingViewModel

### 1. `look_in_map_events_tapped`
- **Método:** `lookInMapEventsTapped()`
- **Descripción:** Se lanza al pulsar para ver los eventos en el mapa.
- **Parámetros:**
  - `places_count` (Int): Número de eventos/lugares mostrados.

---

### 2. `look_in_map_dogs_tapped`
- **Método:** `lookInMapDogsTapped()`
- **Descripción:** Se lanza al pulsar para ver los lugares relacionados con perros en el mapa.
- **Parámetros:**
  - `places_count` (Int): Número de lugares de perros cargados y mostrados.

---

### 3. `look_in_map_markets_tapped`
- **Método:** `lookInMapMarketsTapped()`
- **Descripción:** Se lanza al pulsar para ver los mercados en el mapa.
- **Parámetros:**
  - `places_count` (Int): Número de mercados mostrados.

---

### 4. `look_in_list_events_tapped`
- **Método:** `lookInListEventsTapped()`
- **Descripción:** Se lanza al pulsar para ver la lista de eventos.
- **Parámetros:**
  - `identifier` (String): Identificador del ViewModel o contexto actual.

---

### 5. `look_in_list_markets_tapped`
- **Método:** `lookInListMerchantsTapped()`
- **Descripción:** Se lanza al pulsar para ver la lista de mercados.
- **Parámetros:**
  - `identifier` (String): Identificador del ViewModel o contexto actual.

---

### 6. `initial_tryAgain_button_tapped`
- **Método:** `tryAgain()`
- **Descripción:** Se lanza al pulsar el botón de reintentar carga inicial.
- **Parámetros:** Ninguno.

---

### 7. `event_entry_tapped`
- **Método:** `entryTapped(at:)`
- **Descripción:** Se lanza al seleccionar un evento desde la lista.
- **Parámetros:**
  - `event_id` (String): Identificador del evento seleccionado.
  - `event_title` (String): Título del evento seleccionado.

---

### 8. `event_tapped_on_map`
- **Método:** `eventTappedOnMap(_:)`
- **Descripción:** Se lanza al pulsar un evento en el mapa.
- **Parámetros:**
  - `event_id` (String): Identificador del evento.
  - `event_title` (String): Título del evento.

---

### 9. `market_tapped_on_map`
- **Método:** `marketTappedOnMap(_:)`
- **Descripción:** Se lanza al pulsar un mercado en el mapa.
- **Parámetros:**
  - `market_id` (String): Identificador del mercado.
  - `market_title` (String): Título del mercado.

---

## Notas

- Los eventos suelen enviar parámetros opcionales para enriquecer la información y poder hacer análisis segmentados.  
- Es recomendable mantener actualizado este documento cada vez que se añadan nuevos eventos o se modifiquen los existentes.  
- Para pruebas y debugging, utilizar la herramienta **DebugView** en Firebase Console para verificar que los eventos se envían correctamente en tiempo real.

---
