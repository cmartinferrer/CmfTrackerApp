import Foundation

class EventService {
    static func fetchEvents() -> [Event] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Formato de fecha deseado
        
        // Imagen por defecto en binario (Base64 convertida a Data)
               let defaultImageBase64 = """
               iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABn0lEQVR42mNgQAIS/niK3Ow/Jy/6MzGyD6ghFfQOQv+n7fnLF1p/f//P3I2tiYO+DP/UwIBkxJhBbRT3cfn44v8X//FyPq9x+rAx4///OHu6hNUD+h6sy6fP8v8E9oFBoO/v78fMvT/+zP1++9nBzDxSgMPfP8Dyl7vfyvjAbG/52fVnkfshcZ/mE43v/M4mK3ExEr/T4P9ffPvnwoGpx1/fUj+9frLsweXDFjs+tmDwXwkh+fO+mP79+tnjwAEvH/+9f3qY/W/zA/qwMcToP3tw97XhD9bPjWc/+Xsy+Zm6eTi/x4cvvz46deD+2RucMhuQ5B66J/W3y1ePLMvTg4s+dixOeF54H+MPHi/u3P3xcL/pD/fX98T5Z5fAEygbvh88kH5Cejh78/L3n2hA5w/9Ef9b/wNL94qfLP+j/DK/f6c5/0fwAD/C7/f0Hgxncfye/Pfr5B+/P1SvlC+GBffrBfgAvEFCzHZtCPR4AAEEXe9/UCA5TAAAAAElFTkSuQmCC
               """
               let defaultImageData = Data(base64Encoded: defaultImageBase64)


        return [
            Event(id: 1, title: "Trip and Track", desc: "Evento roadbook que se sale desde el Hotel Terradets.", datetime: "29/03/2025 08:00:00", imageData: defaultImageData),
            Event(id: 2, title: "Legend Book (area  4x4", desc: "Legend book de Area 4x4.  En la Serra de prades", datetime: "05/04/2025 08:00:00", imageData: defaultImageData),
            Event(id: 3, title: "V Ruta Teruel Mudéjar", desc: "V Ruta Teruel Mudéjar off road (Atalaya experiences", datetime: "17/05/2025 08:00:00", imageData: defaultImageData)
        ]
    }
}
