# Changelog - NaerCounter
### Addon para WoW WotLK 3.3.5a (30300) - Naerzone

## [1.0.1-stable] - 2026-10-25

> Estado: **BETA JUGABLE** - Sin Lua Errors. Listo para test en reino real.

### 🛠️ Corregido
- **Lua Error Fix:** Se eliminó `attempt to index field 'db' (a nil value)` al iniciar sesión. Ahora `NS.db` se inicializa de forma segura con `EnsureDB()` en todos los módulos.
- **UI Fix:** `UI:Refresh()` estaba a medias (`-- ... fill rows ...`). Reescrita completa: renderiza filas, contadores, barras de progreso y colores por categoría.
- **Popup Fix:** `StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"]` se redefinía en cada click. Ahora se crea una sola vez y se reutiliza (`or {}`).
- **Tracking Fix:** Detección de rastreo por traducción exacta (`== "buscar hierbas"`) causaba fallo en otros idiomas. Cambiado a búsqueda parcial insensible a mayúsculas.
- **Performance Fix:** Múltiples `BAG_UPDATE` generaban timers sin control. Implementado debounce de 0.3s.

### ✨ Mejorado
- `Counter:GetData()` implementado con soporte de filtro `herbs/minerals` y ordenado por cantidad.
- `RecordGather()` ahora guarda conteo total + por sesión + por zona (`GetRealZoneText()`) compatible con nuevos mapas.
- Compatibilidad total Classic + TBC + WotLK: desde Peacebloom/Copper hasta Lichbloom/Titanium.

### ✅ Verificación
- Sin errores en `/reload`
- Conteo persistente tras relog
- Tracking auto cada 10s funcional
- Botón minimapa y UI abren correctamente

## [1.0.0-Naerzone] - 2026-10-24
- Versión inicial de desarrollo
- Estructura base `.toc` 30300, detección por SpellID y `GetTrackingInfo`
- Idea de contadores y tracking implementada
