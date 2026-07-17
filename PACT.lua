local ADDON_NAME = ...

local PACT = CreateFrame("Frame", "PACTEventFrame")
local LOCALE = GetLocale and GetLocale() or "enUS"

local LOCALES = {
    enUS = {
        ADDON_NAME = "PACT",
        ADDON_LONG_NAME = "Pull And Check Tools",
        LOADED = "loaded. Use /pact to open options.",
        HELP = "commands: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini panel locked.",
        UNLOCKED = "Mini panel unlocked.",
        RESET_POSITION = "Position reset.",
        READY = "Ready Check",
        PULL = "Pull",
        ROLE = "Role Check",
        BREAK = "Break",
        CANCEL = "Cancel",
        NO_PERMISSION = "Requires leader or assistant.",
        DRAG_HANDLE = "Drag to move",
        OPTIONS_TITLE = "PACT",
        OPTIONS_DESC = "Pull And Check Tools for compact raid controls.",
        HIDE_RAID_MANAGER = "Hide Blizzard Raid Manager",
        HIDE_RAID_MANAGER_TIP = "Hides Blizzard's raid manager controls during this session. Party and raid frames remain visible.",
        SHOW_PANEL = "Show mini panel while solo",
        SHOW_PANEL_TIP = "Shows the mini panel while you are solo, so you can position and configure it.",
        LOCK_PANEL = "Lock mini panel",
        LOCK_PANEL_TIP = "Prevents moving the mini panel.",
        SHOW_CANCEL = "Show Cancel button",
        SHOW_CANCEL_TIP = "Adds a compact button that cancels the active countdown.",
        VERTICAL_LAYOUT = "Vertical layout",
        VERTICAL_LAYOUT_TIP = "Stacks the mini panel buttons vertically.",
        REVERSE_ORDER = "Reverse button order",
        REVERSE_ORDER_TIP = "Shows the buttons in the opposite visual order.",
        PANEL_SCALE = "Panel scale",
        PULL_SECONDS = "Pull time",
        BREAK_MINUTES = "Break time",
        PERCENT = "percent",
        SECONDS = "seconds",
        MINUTES = "minutes",
        RESET_POS_BUTTON = "Reset position",
        RESET_DEFAULTS_BUTTON = "Restore defaults",
        READY_TIP = "Starts a ready check.",
        PULL_TIP = "Starts a %d second countdown.",
        TIME_LABEL = "Time: %s",
        ROLE_TIP = "Starts a role check.",
        BREAK_TIP = "Sends the configured break command.",
        CANCEL_TIP = "Cancels the active countdown.",
        READY_UNAVAILABLE = "Ready check is not available in this game version.",
        PULL_UNAVAILABLE = "Countdown is not available in this game version.",
        ROLE_UNAVAILABLE = "Role check is not available in this game version.",
        BREAK_UNAVAILABLE = "Break countdown is not available in this game version.",
        ROLE_PENDING = "Wait for the role check to finish before starting a pull or break.",
        BREAK_PREVIEW = "Break sends: %s",
    },
    ptBR = {
        ADDON_NAME = "PACT",
        ADDON_LONG_NAME = "Ferramentas de Pull e Checks",
        LOADED = "carregado. Use /pact para abrir as opcoes.",
        HELP = "comandos: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini painel travado.",
        UNLOCKED = "Mini painel destravado.",
        RESET_POSITION = "Posicao resetada.",
        READY = "Ready Check",
        PULL = "Pull",
        ROLE = "Role Check",
        BREAK = "Break",
        CANCEL = "Cancel",
        NO_PERMISSION = "Requer lider ou assistente.",
        DRAG_HANDLE = "Arraste para mover",
        OPTIONS_TITLE = "PACT",
        OPTIONS_DESC = "Ferramentas de Pull e Checks para controles compactos de raid.",
        HIDE_RAID_MANAGER = "Esconder Raid Manager da Blizzard",
        HIDE_RAID_MANAGER_TIP = "Esconde os controles do Raid Manager da Blizzard durante esta sessao. Os frames de grupo e raid continuam visiveis.",
        SHOW_PANEL = "Exibir mini painel fora de grupo/raid",
        SHOW_PANEL_TIP = "Mostra o mini painel enquanto voce esta solo, para posicionar e configurar.",
        LOCK_PANEL = "Travar mini painel",
        LOCK_PANEL_TIP = "Impede mover o mini painel.",
        SHOW_CANCEL = "Mostrar botao Cancel",
        SHOW_CANCEL_TIP = "Adiciona um botao compacto que cancela a contagem ativa.",
        VERTICAL_LAYOUT = "Layout vertical",
        VERTICAL_LAYOUT_TIP = "Empilha os botoes do mini painel na vertical.",
        REVERSE_ORDER = "Inverter ordem dos botoes",
        REVERSE_ORDER_TIP = "Mostra os botoes na ordem visual oposta.",
        PANEL_SCALE = "Escala do painel",
        PULL_SECONDS = "Tempo do pull",
        BREAK_MINUTES = "Tempo do break",
        PERCENT = "por cento",
        SECONDS = "segundos",
        MINUTES = "minutos",
        RESET_POS_BUTTON = "Resetar posicao",
        RESET_DEFAULTS_BUTTON = "Restaurar padroes",
        READY_TIP = "Inicia um ready check.",
        PULL_TIP = "Inicia uma contagem de %d segundos.",
        TIME_LABEL = "Tempo: %s",
        ROLE_TIP = "Inicia um role check.",
        BREAK_TIP = "Envia o comando de break configurado.",
        CANCEL_TIP = "Cancela a contagem ativa.",
        READY_UNAVAILABLE = "Ready check nao esta disponivel nesta versao do jogo.",
        PULL_UNAVAILABLE = "Countdown nao esta disponivel nesta versao do jogo.",
        ROLE_UNAVAILABLE = "Role check nao esta disponivel nesta versao do jogo.",
        BREAK_UNAVAILABLE = "Countdown de break nao esta disponivel nesta versao do jogo.",
        ROLE_PENDING = "Aguarde o Role Check terminar antes de iniciar pull ou break.",
        BREAK_PREVIEW = "Break envia: %s",
    },
    deDE = {
        LOADED = "geladen. Benutze /pact, um die Optionen zu oeffnen.",
        HELP = "Befehle: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Minifenster gesperrt.",
        UNLOCKED = "Minifenster entsperrt.",
        RESET_POSITION = "Position zurueckgesetzt.",
        READY = "Bereitschaftscheck",
        PULL = "Pull",
        ROLE = "Rollencheck",
        BREAK = "Pause",
        CANCEL = "Abbrechen",
        NO_PERMISSION = "Benötigt Anführer oder Assistent.",
        DRAG_HANDLE = "Zum Verschieben ziehen",
        OPTIONS_DESC = "Pull And Check Tools fuer kompakte Schlachtzugsteuerung.",
        HIDE_RAID_MANAGER = "Blizzard-Raidmanager ausblenden",
        HIDE_RAID_MANAGER_TIP = "Blendet die Bedienelemente des Blizzard-Raidmanagers in dieser Sitzung aus. Gruppen- und Schlachtzugsfenster bleiben sichtbar.",
        SHOW_PANEL = "Minifenster solo anzeigen",
        SHOW_PANEL_TIP = "Zeigt das Minifenster solo an, damit du es positionieren kannst.",
        LOCK_PANEL = "Minifenster sperren",
        LOCK_PANEL_TIP = "Verhindert das Verschieben des Minifensters.",
        SHOW_CANCEL = "Abbrechen-Schaltflaeche anzeigen",
        SHOW_CANCEL_TIP = "Fuegt eine kompakte Schaltflaeche hinzu, die den aktiven Countdown abbricht.",
        VERTICAL_LAYOUT = "Vertikales Layout",
        VERTICAL_LAYOUT_TIP = "Stapelt die Schaltflaechen des Minifensters vertikal.",
        REVERSE_ORDER = "Reihenfolge umkehren",
        REVERSE_ORDER_TIP = "Zeigt die Schaltflaechen in umgekehrter visueller Reihenfolge.",
        PANEL_SCALE = "Fensterskalierung",
        PULL_SECONDS = "Pull-Zeit",
        BREAK_MINUTES = "Pausenzeit",
        PERCENT = "Prozent",
        SECONDS = "Sekunden",
        MINUTES = "Minuten",
        RESET_POS_BUTTON = "Position zuruecksetzen",
        RESET_DEFAULTS_BUTTON = "Standardwerte",
        READY_TIP = "Startet einen Bereitschaftscheck.",
        PULL_TIP = "Startet einen Countdown von %d Sekunden.",
        TIME_LABEL = "Zeit: %s",
        ROLE_TIP = "Startet einen Rollencheck.",
        BREAK_TIP = "Sendet den konfigurierten Pausenbefehl.",
        CANCEL_TIP = "Bricht den aktiven Countdown ab.",
        READY_UNAVAILABLE = "Bereitschaftscheck ist in dieser Spielversion nicht verfuegbar.",
        PULL_UNAVAILABLE = "Countdown ist in dieser Spielversion nicht verfuegbar.",
        ROLE_UNAVAILABLE = "Rollencheck ist in dieser Spielversion nicht verfuegbar.",
        BREAK_UNAVAILABLE = "Pausen-Countdown ist in dieser Spielversion nicht verfuegbar.",
        ROLE_PENDING = "Warte, bis der Rollencheck beendet ist, bevor du Pull oder Pause startest.",
        BREAK_PREVIEW = "Pause sendet: %s",
    },
    esES = {
        LOADED = "cargado. Usa /pact para abrir las opciones.",
        HELP = "comandos: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Minipanel bloqueado.",
        UNLOCKED = "Minipanel desbloqueado.",
        RESET_POSITION = "Posicion restablecida.",
        READY = "Comprobacion",
        PULL = "Pull",
        ROLE = "Comprobacion de roles",
        BREAK = "Descanso",
        CANCEL = "Cancelar",
        NO_PERMISSION = "Requiere lider o asistente.",
        DRAG_HANDLE = "Arrastra para mover",
        OPTIONS_DESC = "Pull And Check Tools para controles compactos de banda.",
        HIDE_RAID_MANAGER = "Ocultar gestor de banda de Blizzard",
        HIDE_RAID_MANAGER_TIP = "Oculta los controles del Raid Manager de Blizzard durante esta sesion. Los marcos de grupo y banda permanecen visibles.",
        SHOW_PANEL = "Mostrar minipanel estando solo",
        SHOW_PANEL_TIP = "Muestra el minipanel estando solo para poder colocarlo.",
        LOCK_PANEL = "Bloquear minipanel",
        LOCK_PANEL_TIP = "Impide mover el minipanel.",
        SHOW_CANCEL = "Mostrar boton Cancelar",
        SHOW_CANCEL_TIP = "Anade un boton compacto que cancela la cuenta atras activa.",
        VERTICAL_LAYOUT = "Diseno vertical",
        VERTICAL_LAYOUT_TIP = "Apila verticalmente los botones del minipanel.",
        REVERSE_ORDER = "Invertir orden de botones",
        REVERSE_ORDER_TIP = "Muestra los botones en el orden visual opuesto.",
        PANEL_SCALE = "Escala del panel",
        PULL_SECONDS = "Tiempo de pull",
        BREAK_MINUTES = "Tiempo de descanso",
        PERCENT = "por ciento",
        SECONDS = "segundos",
        MINUTES = "minutos",
        RESET_POS_BUTTON = "Restablecer posicion",
        RESET_DEFAULTS_BUTTON = "Restaurar valores",
        READY_TIP = "Inicia una comprobacion.",
        PULL_TIP = "Inicia una cuenta atras de %d segundos.",
        TIME_LABEL = "Tiempo: %s",
        ROLE_TIP = "Inicia una comprobacion de roles.",
        BREAK_TIP = "Envia el comando de descanso configurado.",
        CANCEL_TIP = "Cancela la cuenta atras activa.",
        READY_UNAVAILABLE = "La comprobacion no esta disponible en esta version del juego.",
        PULL_UNAVAILABLE = "La cuenta atras no esta disponible en esta version del juego.",
        ROLE_UNAVAILABLE = "La comprobacion de roles no esta disponible en esta version del juego.",
        BREAK_UNAVAILABLE = "La cuenta atras de descanso no esta disponible en esta version del juego.",
        ROLE_PENDING = "Espera a que termine la comprobacion de roles antes de iniciar pull o descanso.",
        BREAK_PREVIEW = "Descanso envia: %s",
    },
    esMX = {
        LOADED = "cargado. Usa /pact para abrir las opciones.",
        HELP = "comandos: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Minipanel bloqueado.",
        UNLOCKED = "Minipanel desbloqueado.",
        RESET_POSITION = "Posicion reiniciada.",
        READY = "Comprobacion",
        PULL = "Pull",
        ROLE = "Comprobacion de roles",
        BREAK = "Descanso",
        CANCEL = "Cancelar",
        NO_PERMISSION = "Requiere lider o asistente.",
        DRAG_HANDLE = "Arrastra para mover",
        OPTIONS_DESC = "Pull And Check Tools para controles compactos de raid.",
        HIDE_RAID_MANAGER = "Ocultar Raid Manager de Blizzard",
        HIDE_RAID_MANAGER_TIP = "Oculta los controles del Raid Manager de Blizzard durante esta sesion. Los marcos de grupo y banda permanecen visibles.",
        SHOW_PANEL = "Mostrar minipanel estando solo",
        SHOW_PANEL_TIP = "Muestra el minipanel estando solo para poder posicionarlo.",
        LOCK_PANEL = "Bloquear minipanel",
        LOCK_PANEL_TIP = "Impide mover el minipanel.",
        SHOW_CANCEL = "Mostrar boton Cancelar",
        SHOW_CANCEL_TIP = "Agrega un boton compacto que cancela la cuenta regresiva activa.",
        VERTICAL_LAYOUT = "Diseno vertical",
        VERTICAL_LAYOUT_TIP = "Apila verticalmente los botones del minipanel.",
        REVERSE_ORDER = "Invertir orden de botones",
        REVERSE_ORDER_TIP = "Muestra los botones en el orden visual opuesto.",
        PANEL_SCALE = "Escala del panel",
        PULL_SECONDS = "Tiempo de pull",
        BREAK_MINUTES = "Tiempo de descanso",
        PERCENT = "por ciento",
        SECONDS = "segundos",
        MINUTES = "minutos",
        RESET_POS_BUTTON = "Reiniciar posicion",
        RESET_DEFAULTS_BUTTON = "Restaurar valores",
        READY_TIP = "Inicia una comprobacion.",
        PULL_TIP = "Inicia una cuenta regresiva de %d segundos.",
        TIME_LABEL = "Tiempo: %s",
        ROLE_TIP = "Inicia una comprobacion de roles.",
        BREAK_TIP = "Envia el comando de descanso configurado.",
        CANCEL_TIP = "Cancela la cuenta regresiva activa.",
        READY_UNAVAILABLE = "La comprobacion no esta disponible en esta version del juego.",
        PULL_UNAVAILABLE = "La cuenta regresiva no esta disponible en esta version del juego.",
        ROLE_UNAVAILABLE = "La comprobacion de roles no esta disponible en esta version del juego.",
        BREAK_UNAVAILABLE = "La cuenta regresiva de descanso no esta disponible en esta version del juego.",
        ROLE_PENDING = "Espera a que termine la comprobacion de roles antes de iniciar pull o descanso.",
        BREAK_PREVIEW = "Descanso envia: %s",
    },
    frFR = {
        LOADED = "charge. Utilisez /pact pour ouvrir les options.",
        HELP = "commandes : /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini-panneau verrouille.",
        UNLOCKED = "Mini-panneau deverrouille.",
        RESET_POSITION = "Position reinitialisee.",
        READY = "Appel pret",
        PULL = "Pull",
        ROLE = "Verification des roles",
        BREAK = "Pause",
        CANCEL = "Annuler",
        NO_PERMISSION = "Necessite le chef ou un assistant.",
        DRAG_HANDLE = "Faire glisser pour deplacer",
        OPTIONS_DESC = "Pull And Check Tools pour controles de raid compacts.",
        HIDE_RAID_MANAGER = "Masquer le gestionnaire de raid Blizzard",
        HIDE_RAID_MANAGER_TIP = "Masque les commandes du gestionnaire de raid Blizzard pendant cette session. Les cadres de groupe et de raid restent visibles.",
        SHOW_PANEL = "Afficher le mini-panneau en solo",
        SHOW_PANEL_TIP = "Affiche le mini-panneau en solo pour le positionner.",
        LOCK_PANEL = "Verrouiller le mini-panneau",
        LOCK_PANEL_TIP = "Empeche de deplacer le mini-panneau.",
        SHOW_CANCEL = "Afficher le bouton Annuler",
        SHOW_CANCEL_TIP = "Ajoute un bouton compact qui annule le compte a rebours actif.",
        VERTICAL_LAYOUT = "Disposition verticale",
        VERTICAL_LAYOUT_TIP = "Empile verticalement les boutons du mini-panneau.",
        REVERSE_ORDER = "Inverser l'ordre des boutons",
        REVERSE_ORDER_TIP = "Affiche les boutons dans l'ordre visuel inverse.",
        PANEL_SCALE = "Echelle du panneau",
        PULL_SECONDS = "Temps du pull",
        BREAK_MINUTES = "Temps de pause",
        PERCENT = "pour cent",
        SECONDS = "secondes",
        MINUTES = "minutes",
        RESET_POS_BUTTON = "Reinitialiser position",
        RESET_DEFAULTS_BUTTON = "Valeurs par defaut",
        READY_TIP = "Lance un appel pret.",
        PULL_TIP = "Lance un compte a rebours de %d secondes.",
        TIME_LABEL = "Temps : %s",
        ROLE_TIP = "Lance une verification des roles.",
        BREAK_TIP = "Envoie la commande de pause configuree.",
        CANCEL_TIP = "Annule le compte a rebours actif.",
        READY_UNAVAILABLE = "L'appel pret n'est pas disponible dans cette version du jeu.",
        PULL_UNAVAILABLE = "Le compte a rebours n'est pas disponible dans cette version du jeu.",
        ROLE_UNAVAILABLE = "La verification des roles n'est pas disponible dans cette version du jeu.",
        BREAK_UNAVAILABLE = "Le compte a rebours de pause n'est pas disponible dans cette version du jeu.",
        ROLE_PENDING = "Attendez la fin de la verification des roles avant de lancer pull ou pause.",
        BREAK_PREVIEW = "Pause envoie : %s",
    },
    itIT = {
        LOADED = "caricato. Usa /pact per aprire le opzioni.",
        HELP = "comandi: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Mini pannello bloccato.",
        UNLOCKED = "Mini pannello sbloccato.",
        RESET_POSITION = "Posizione reimpostata.",
        READY = "Controllo pronti",
        PULL = "Pull",
        ROLE = "Controllo ruoli",
        BREAK = "Pausa",
        CANCEL = "Annulla",
        NO_PERMISSION = "Richiede capogruppo o assistente.",
        DRAG_HANDLE = "Trascina per spostare",
        OPTIONS_DESC = "Pull And Check Tools per controlli raid compatti.",
        HIDE_RAID_MANAGER = "Nascondi Raid Manager Blizzard",
        HIDE_RAID_MANAGER_TIP = "Nasconde i controlli del Raid Manager Blizzard durante questa sessione. I riquadri di gruppo e raid restano visibili.",
        SHOW_PANEL = "Mostra mini pannello da solo",
        SHOW_PANEL_TIP = "Mostra il mini pannello quando sei solo, per posizionarlo.",
        LOCK_PANEL = "Blocca mini pannello",
        LOCK_PANEL_TIP = "Impedisce di spostare il mini pannello.",
        SHOW_CANCEL = "Mostra pulsante Annulla",
        SHOW_CANCEL_TIP = "Aggiunge un pulsante compatto che annulla il conto alla rovescia attivo.",
        VERTICAL_LAYOUT = "Layout verticale",
        VERTICAL_LAYOUT_TIP = "Impila verticalmente i pulsanti del mini pannello.",
        REVERSE_ORDER = "Inverti ordine pulsanti",
        REVERSE_ORDER_TIP = "Mostra i pulsanti nell'ordine visivo opposto.",
        PANEL_SCALE = "Scala pannello",
        PULL_SECONDS = "Tempo pull",
        BREAK_MINUTES = "Tempo pausa",
        PERCENT = "percento",
        SECONDS = "secondi",
        MINUTES = "minuti",
        RESET_POS_BUTTON = "Reimposta posizione",
        RESET_DEFAULTS_BUTTON = "Ripristina valori",
        READY_TIP = "Avvia un controllo pronti.",
        PULL_TIP = "Avvia un conto alla rovescia di %d secondi.",
        TIME_LABEL = "Tempo: %s",
        ROLE_TIP = "Avvia un controllo ruoli.",
        BREAK_TIP = "Invia il comando pausa configurato.",
        CANCEL_TIP = "Annulla il conto alla rovescia attivo.",
        READY_UNAVAILABLE = "Il controllo pronti non e disponibile in questa versione del gioco.",
        PULL_UNAVAILABLE = "Il conto alla rovescia non e disponibile in questa versione del gioco.",
        ROLE_UNAVAILABLE = "Il controllo ruoli non e disponibile in questa versione del gioco.",
        BREAK_UNAVAILABLE = "Il conto alla rovescia di pausa non e disponibile in questa versione del gioco.",
        ROLE_PENDING = "Attendi la fine del controllo ruoli prima di avviare pull o pausa.",
        BREAK_PREVIEW = "Pausa invia: %s",
    },
    koKR = {
        LOADED = "로드되었습니다. 옵션을 열려면 /pact 를 사용하세요.",
        HELP = "명령어: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "미니 패널 잠김.",
        UNLOCKED = "미니 패널 잠금 해제.",
        RESET_POSITION = "위치 초기화됨.",
        READY = "준비 확인",
        PULL = "풀",
        ROLE = "역할 확인",
        BREAK = "휴식",
        CANCEL = "취소",
        NO_PERMISSION = "공격대장 또는 부공격대장이 필요합니다.",
        DRAG_HANDLE = "드래그하여 이동",
        OPTIONS_DESC = "간단한 공격대 제어용 Pull And Check Tools.",
        HIDE_RAID_MANAGER = "Blizzard 공격대 관리자 숨기기",
        HIDE_RAID_MANAGER_TIP = "이번 세션 동안 Blizzard 공격대 관리자 조작부를 숨깁니다. 파티 및 공격대 창은 계속 표시됩니다.",
        SHOW_PANEL = "솔로일 때 미니 패널 표시",
        SHOW_PANEL_TIP = "솔로일 때 위치 조정을 위해 미니 패널을 표시합니다.",
        LOCK_PANEL = "미니 패널 잠금",
        LOCK_PANEL_TIP = "미니 패널 이동을 막습니다.",
        SHOW_CANCEL = "취소 버튼 표시",
        SHOW_CANCEL_TIP = "활성 카운트다운을 취소하는 작은 버튼을 추가합니다.",
        VERTICAL_LAYOUT = "세로 배치",
        VERTICAL_LAYOUT_TIP = "미니 패널 버튼을 세로로 배치합니다.",
        REVERSE_ORDER = "버튼 순서 반전",
        REVERSE_ORDER_TIP = "버튼을 반대 순서로 표시합니다.",
        PANEL_SCALE = "패널 크기",
        PULL_SECONDS = "풀 시간",
        BREAK_MINUTES = "휴식 시간",
        PERCENT = "퍼센트",
        SECONDS = "초",
        MINUTES = "분",
        RESET_POS_BUTTON = "위치 초기화",
        RESET_DEFAULTS_BUTTON = "기본값 복원",
        READY_TIP = "준비 확인을 시작합니다.",
        PULL_TIP = "%d초 카운트다운을 시작합니다.",
        TIME_LABEL = "시간: %s",
        ROLE_TIP = "역할 확인을 시작합니다.",
        BREAK_TIP = "설정된 휴식 명령을 보냅니다.",
        CANCEL_TIP = "활성 카운트다운을 취소합니다.",
        READY_UNAVAILABLE = "이 게임 버전에서는 준비 확인을 사용할 수 없습니다.",
        PULL_UNAVAILABLE = "이 게임 버전에서는 카운트다운을 사용할 수 없습니다.",
        ROLE_UNAVAILABLE = "이 게임 버전에서는 역할 확인을 사용할 수 없습니다.",
        BREAK_UNAVAILABLE = "이 게임 버전에서는 휴식 카운트다운을 사용할 수 없습니다.",
        ROLE_PENDING = "역할 확인이 끝난 뒤 풀 또는 휴식을 시작하세요.",
        BREAK_PREVIEW = "휴식 전송: %s",
    },
    ruRU = {
        LOADED = "загружен. Используйте /pact, чтобы открыть настройки.",
        HELP = "команды: /pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "Мини-панель заблокирована.",
        UNLOCKED = "Мини-панель разблокирована.",
        RESET_POSITION = "Позиция сброшена.",
        READY = "Проверка готовности",
        PULL = "Пулл",
        ROLE = "Проверка ролей",
        BREAK = "Перерыв",
        CANCEL = "Отмена",
        NO_PERMISSION = "Требуется лидер или помощник.",
        DRAG_HANDLE = "Перетащите для перемещения",
        OPTIONS_DESC = "Pull And Check Tools для компактного управления рейдом.",
        HIDE_RAID_MANAGER = "Скрыть менеджер рейда Blizzard",
        HIDE_RAID_MANAGER_TIP = "Скрывает элементы управления рейд-менеджером Blizzard на эту сессию. Окна группы и рейда остаются видимыми.",
        SHOW_PANEL = "Показывать мини-панель соло",
        SHOW_PANEL_TIP = "Показывает мини-панель соло, чтобы ее можно было разместить.",
        LOCK_PANEL = "Заблокировать мини-панель",
        LOCK_PANEL_TIP = "Запрещает перемещение мини-панели.",
        SHOW_CANCEL = "Показать кнопку отмены",
        SHOW_CANCEL_TIP = "Добавляет компактную кнопку, отменяющую активный отсчет.",
        VERTICAL_LAYOUT = "Вертикальный макет",
        VERTICAL_LAYOUT_TIP = "Располагает кнопки мини-панели вертикально.",
        REVERSE_ORDER = "Обратный порядок кнопок",
        REVERSE_ORDER_TIP = "Показывает кнопки в обратном визуальном порядке.",
        PANEL_SCALE = "Масштаб панели",
        PULL_SECONDS = "Время пулла",
        BREAK_MINUTES = "Время перерыва",
        PERCENT = "процентов",
        SECONDS = "секунды",
        MINUTES = "минуты",
        RESET_POS_BUTTON = "Сбросить позицию",
        RESET_DEFAULTS_BUTTON = "По умолчанию",
        READY_TIP = "Запускает проверку готовности.",
        PULL_TIP = "Запускает отсчет на %d сек.",
        TIME_LABEL = "Время: %s",
        ROLE_TIP = "Запускает проверку ролей.",
        BREAK_TIP = "Отправляет настроенную команду перерыва.",
        CANCEL_TIP = "Отменяет активный отсчет.",
        READY_UNAVAILABLE = "Проверка готовности недоступна в этой версии игры.",
        PULL_UNAVAILABLE = "Отсчет недоступен в этой версии игры.",
        ROLE_UNAVAILABLE = "Проверка ролей недоступна в этой версии игры.",
        BREAK_UNAVAILABLE = "Отсчет перерыва недоступен в этой версии игры.",
        ROLE_PENDING = "Дождитесь завершения проверки ролей перед пуллом или перерывом.",
        BREAK_PREVIEW = "Перерыв отправляет: %s",
    },
    zhCN = {
        LOADED = "已加载。使用 /pact 打开选项。",
        HELP = "命令：/pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "迷你面板已锁定。",
        UNLOCKED = "迷你面板已解锁。",
        RESET_POSITION = "位置已重置。",
        READY = "就绪检查",
        PULL = "开怪",
        ROLE = "职责检查",
        BREAK = "休息",
        CANCEL = "取消",
        NO_PERMISSION = "需要队长或助理权限。",
        DRAG_HANDLE = "拖动移动",
        OPTIONS_DESC = "用于紧凑团队控制的 Pull And Check Tools。",
        HIDE_RAID_MANAGER = "隐藏 Blizzard 团队管理器",
        HIDE_RAID_MANAGER_TIP = "在本次会话中隐藏 Blizzard 团队管理器控制项。小队和团队框体仍会显示。",
        SHOW_PANEL = "单人时显示迷你面板",
        SHOW_PANEL_TIP = "单人时显示迷你面板，方便调整位置。",
        LOCK_PANEL = "锁定迷你面板",
        LOCK_PANEL_TIP = "防止移动迷你面板。",
        SHOW_CANCEL = "显示取消按钮",
        SHOW_CANCEL_TIP = "添加一个用于取消当前倒计时的小按钮。",
        VERTICAL_LAYOUT = "垂直布局",
        VERTICAL_LAYOUT_TIP = "垂直排列迷你面板按钮。",
        REVERSE_ORDER = "反转按钮顺序",
        REVERSE_ORDER_TIP = "以相反的视觉顺序显示按钮。",
        PANEL_SCALE = "面板缩放",
        PULL_SECONDS = "开怪时间",
        BREAK_MINUTES = "休息时间",
        PERCENT = "百分比",
        SECONDS = "秒",
        MINUTES = "分钟",
        RESET_POS_BUTTON = "重置位置",
        RESET_DEFAULTS_BUTTON = "恢复默认",
        READY_TIP = "开始就绪检查。",
        PULL_TIP = "开始 %d 秒倒计时。",
        TIME_LABEL = "时间：%s",
        ROLE_TIP = "开始职责检查。",
        BREAK_TIP = "发送已配置的休息命令。",
        CANCEL_TIP = "取消当前倒计时。",
        READY_UNAVAILABLE = "此游戏版本不支持就绪检查。",
        PULL_UNAVAILABLE = "此游戏版本不支持倒计时。",
        ROLE_UNAVAILABLE = "此游戏版本不支持职责检查。",
        BREAK_UNAVAILABLE = "此游戏版本不支持休息倒计时。",
        ROLE_PENDING = "请等待职责检查结束后再开始开怪或休息。",
        BREAK_PREVIEW = "休息发送：%s",
    },
    zhTW = {
        LOADED = "已載入。使用 /pact 開啟選項。",
        HELP = "指令：/pact, /pact lock, /pact unlock, /pact reset, /pact blizzard",
        LOCKED = "迷你面板已鎖定。",
        UNLOCKED = "迷你面板已解鎖。",
        RESET_POSITION = "位置已重設。",
        READY = "準備確認",
        PULL = "開怪",
        ROLE = "職責確認",
        BREAK = "休息",
        CANCEL = "取消",
        NO_PERMISSION = "需要隊長或助理權限。",
        DRAG_HANDLE = "拖曳以移動",
        OPTIONS_DESC = "用於精簡團隊控制的 Pull And Check Tools。",
        HIDE_RAID_MANAGER = "隱藏 Blizzard 團隊管理器",
        HIDE_RAID_MANAGER_TIP = "在本次遊戲階段隱藏 Blizzard 團隊管理員控制項。隊伍和團隊框架仍會顯示。",
        SHOW_PANEL = "單人時顯示迷你面板",
        SHOW_PANEL_TIP = "單人時顯示迷你面板，方便調整位置。",
        LOCK_PANEL = "鎖定迷你面板",
        LOCK_PANEL_TIP = "防止移動迷你面板。",
        SHOW_CANCEL = "顯示取消按鈕",
        SHOW_CANCEL_TIP = "加入一個用來取消目前倒數的小按鈕。",
        VERTICAL_LAYOUT = "垂直佈局",
        VERTICAL_LAYOUT_TIP = "垂直排列迷你面板按鈕。",
        REVERSE_ORDER = "反轉按鈕順序",
        REVERSE_ORDER_TIP = "以相反的視覺順序顯示按鈕。",
        PANEL_SCALE = "面板縮放",
        PULL_SECONDS = "開怪時間",
        BREAK_MINUTES = "休息時間",
        PERCENT = "百分比",
        SECONDS = "秒",
        MINUTES = "分鐘",
        RESET_POS_BUTTON = "重設位置",
        RESET_DEFAULTS_BUTTON = "恢復預設",
        READY_TIP = "開始準備確認。",
        PULL_TIP = "開始 %d 秒倒數。",
        TIME_LABEL = "時間：%s",
        ROLE_TIP = "開始職責確認。",
        BREAK_TIP = "送出已設定的休息指令。",
        CANCEL_TIP = "取消目前倒數。",
        READY_UNAVAILABLE = "此遊戲版本不支援準備確認。",
        PULL_UNAVAILABLE = "此遊戲版本不支援倒數。",
        ROLE_UNAVAILABLE = "此遊戲版本不支援職責確認。",
        BREAK_UNAVAILABLE = "此遊戲版本不支援休息倒數。",
        ROLE_PENDING = "請等待職責確認結束後再開始開怪或休息。",
        BREAK_PREVIEW = "休息送出：%s",
    },
}

LOCALES.enGB = LOCALES.enUS

local function GetLocalizedStrings(locale)
    local strings = LOCALES[locale] or LOCALES.enUS
    if strings ~= LOCALES.enUS then
        setmetatable(strings, { __index = LOCALES.enUS })
    end
    return strings
end

local L = GetLocalizedStrings(LOCALE)

local DEFAULT_DB = {
    version = 1,
    showPanel = true,
    locked = false,
    hideRaidManager = false,
    showCancelButton = false,
    verticalLayout = false,
    reverseOrder = false,
    panelScale = 100,
    pullSeconds = 10,
    breakMinutes = 5,
    breakCommand = "/break {minutes}",
    position = {
        point = "CENTER",
        relativePoint = "CENTER",
        x = 0,
        y = 120,
    },
}

local BUTTON_SIZE = 24
local GAP = 3
local PAD = 4
local HANDLE_WIDTH = 8

local db
local panel
local handle
local handleDots = {}
local optionsPanel
local standaloneWindow
local settingsCategory
local pendingLayoutUpdate
local pendingRaidManagerUpdate
local breakCancelPending
local breakCancelToken = 0
local roleCheckPending
local roleCheckToken = 0

local buttons = {}
local buttonOrder = { "ready", "pull", "role", "break", "cancel" }

local raidManagerHiddenByPACT
local raidManagerRestoring
local raidContainerDetached
local raidContainerOriginalParent

local function CopyDefaults(source)
    local copy = {}
    for key, value in pairs(source) do
        if type(value) == "table" then
            copy[key] = CopyDefaults(value)
        else
            copy[key] = value
        end
    end
    return copy
end

local function MergeDefaults(target, defaults)
    for key, value in pairs(defaults) do
        if type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = CopyDefaults(value)
            else
                MergeDefaults(target[key], value)
            end
        elseif type(target[key]) ~= type(value) then
            target[key] = value
        end
    end
end

local function ClampInt(value, minimum, maximum, fallback)
    value = tonumber(value)
    if not value then
        value = fallback
    end
    value = math.floor(value + 0.5)
    if value < minimum then
        value = minimum
    elseif value > maximum then
        value = maximum
    end
    return value
end

local function EnsureDb()
    if type(PACTDB) ~= "table" then
        PACTDB = CopyDefaults(DEFAULT_DB)
    else
        MergeDefaults(PACTDB, DEFAULT_DB)
    end

    db = PACTDB
    db.pullSeconds = ClampInt(db.pullSeconds, 1, 3600, DEFAULT_DB.pullSeconds)
    db.breakMinutes = ClampInt(db.breakMinutes, 1, 60, DEFAULT_DB.breakMinutes)
    db.panelScale = ClampInt(db.panelScale, 80, 140, DEFAULT_DB.panelScale)

    if type(db.breakCommand) ~= "string" or db.breakCommand == "" then
        db.breakCommand = DEFAULT_DB.breakCommand
    else
        local savedBreakCommand = db.breakCommand:gsub("[\r\n]", " "):match("^%s*(.-)%s*$") or ""
        if savedBreakCommand:sub(1, 1) ~= "/" then
            savedBreakCommand = "/" .. savedBreakCommand
        end
        if savedBreakCommand == "/pull {seconds} break" then
            db.breakCommand = DEFAULT_DB.breakCommand
        end
    end

    if type(db.position) ~= "table" then
        db.position = CopyDefaults(DEFAULT_DB.position)
    end
    db.position.point = db.position.point or DEFAULT_DB.position.point
    db.position.relativePoint = db.position.relativePoint or DEFAULT_DB.position.relativePoint
    db.position.x = tonumber(db.position.x) or DEFAULT_DB.position.x
    db.position.y = tonumber(db.position.y) or DEFAULT_DB.position.y

    return db
end

local function Print(message)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PACT:|r " .. tostring(message))
    else
        print("PACT: " .. tostring(message))
    end
end

local function InCombat()
    return InCombatLockdown and InCombatLockdown()
end

local function IsGrouped()
    if IsInRaid and IsInRaid() then
        return true
    end
    if IsInGroup and IsInGroup() then
        return true
    end
    if GetNumGroupMembers and GetNumGroupMembers() > 0 then
        return true
    end
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        return true
    end
    if GetNumPartyMembers and GetNumPartyMembers() > 0 then
        return true
    end
    return false
end

local function HasPermission()
    if not IsGrouped() then
        return true
    end
    if UnitIsGroupLeader and UnitIsGroupLeader("player") then
        return true
    end
    if UnitIsGroupAssistant and UnitIsGroupAssistant("player") then
        return true
    end
    if IsRaidLeader and IsRaidLeader() then
        return true
    end
    if IsRaidOfficer and IsRaidOfficer() then
        return true
    end
    return false
end

local function IsAvailable()
    if IsGrouped() then
        return HasPermission()
    end
    return db.showPanel
end

local function SavePosition()
    if not panel or not db then
        return
    end

    local point, _, relativePoint, x, y = panel:GetPoint(1)
    db.position.point = point or DEFAULT_DB.position.point
    db.position.relativePoint = relativePoint or DEFAULT_DB.position.relativePoint
    db.position.x = x or DEFAULT_DB.position.x
    db.position.y = y or DEFAULT_DB.position.y
end

local function LoadPosition()
    if not panel or not db then
        return
    end

    panel:ClearAllPoints()
    panel:SetPoint(db.position.point, UIParent, db.position.relativePoint, db.position.x, db.position.y)
end

local function FormatDuration(seconds)
    seconds = tonumber(seconds) or 0
    if seconds >= 60 and seconds % 60 == 0 then
        return tostring(seconds / 60) .. " min"
    end
    return tostring(seconds) .. " s"
end

local function SanitizeMacro(text)
    text = tostring(text or "")
    text = text:gsub("[\r\n]", " ")
    text = text:match("^%s*(.-)%s*$") or ""
    if text == "" then
        text = DEFAULT_DB.breakCommand
    end
    if text:sub(1, 1) ~= "/" then
        text = "/" .. text
    end
    return text
end

local function ExpandBreakCommand()
    local seconds = db.breakMinutes * 60
    local text = SanitizeMacro(db.breakCommand)
    text = text:gsub("{seconds}", tostring(seconds))
    text = text:gsub("{minutes}", tostring(db.breakMinutes))
    text = text:gsub("{pull}", tostring(db.pullSeconds))
    return text
end

local function RunSlashCommand(command)
    local slash, args = tostring(command or ""):match("^/([^%s]+)%s*(.*)$")
    if not slash then
        return false
    end

    local handler = SlashCmdList and (SlashCmdList[slash] or SlashCmdList[slash:lower()] or SlashCmdList[slash:upper()])
    if not handler then
        return false
    end

    handler(args or "")
    return true
end

local function IsRoleCheckPending()
    if roleCheckPending then
        return true
    end
    return RolePollPopup and RolePollPopup:IsShown()
end

local function ClearRoleCheckPending()
    roleCheckPending = nil
    roleCheckToken = roleCheckToken + 1
end

local function MarkRoleCheckPending()
    roleCheckPending = true
    roleCheckToken = roleCheckToken + 1

    local token = roleCheckToken
    if C_Timer and C_Timer.After then
        C_Timer.After(45, function()
            if roleCheckToken == token then
                roleCheckPending = nil
            end
        end)
    end
end

local function ApplyBackdrop(frame, bgR, bgG, bgB, bgA, borderR, borderG, borderB, borderA)
    if not frame.SetBackdrop then
        return
    end

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 8,
        edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    frame:SetBackdropColor(bgR or 0, bgG or 0, bgB or 0, bgA or 0.75)
    frame:SetBackdropBorderColor(borderR or 0.45, borderG or 0.45, borderB or 0.45, borderA or 1)
end

local function ShowButtonTooltip(button, key)
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT")

    if key == "ready" then
        GameTooltip:SetText(L.READY)
        GameTooltip:AddLine(L.READY_TIP, 1, 1, 1, true)
    elseif key == "pull" then
        GameTooltip:SetText(L.PULL)
        GameTooltip:AddLine(L.PULL_TIP:format(db.pullSeconds), 1, 1, 1, true)
        GameTooltip:AddLine(L.TIME_LABEL:format(FormatDuration(db.pullSeconds)), 0.8, 0.8, 0.8, true)
    elseif key == "role" then
        GameTooltip:SetText(L.ROLE)
        GameTooltip:AddLine(L.ROLE_TIP, 1, 1, 1, true)
    elseif key == "break" then
        GameTooltip:SetText(L.BREAK)
        GameTooltip:AddLine(L.BREAK_TIP, 1, 1, 1, true)
        GameTooltip:AddLine(L.TIME_LABEL:format(FormatDuration(db.breakMinutes * 60)), 0.8, 0.8, 0.8, true)
        GameTooltip:AddLine(ExpandBreakCommand(), 0.6, 0.9, 1, true)
    elseif key == "cancel" then
        GameTooltip:SetText(L.CANCEL)
        GameTooltip:AddLine(L.CANCEL_TIP, 1, 1, 1, true)
    elseif key == "handle" then
        GameTooltip:SetText(L.DRAG_HANDLE)
        GameTooltip:AddLine(db.locked and L.LOCKED or L.UNLOCKED, 1, 1, 1, true)
    end

    if IsGrouped() and not HasPermission() then
        GameTooltip:AddLine(L.NO_PERMISSION, 1, 0.35, 0.35, true)
    elseif (key == "pull" or key == "break") and roleCheckPending then
        GameTooltip:AddLine(L.ROLE_PENDING, 1, 0.35, 0.35, true)
    end

    GameTooltip:Show()
end

local function CreateFrameWithBackdrop(frameType, name, parent, template)
    local templateText = template and (template .. ",BackdropTemplate") or "BackdropTemplate"
    local ok, frame = pcall(CreateFrame, frameType, name, parent, templateText)
    if ok and frame then
        return frame
    end
    return CreateFrame(frameType, name, parent, template)
end

local function CreateIconButton(key, iconPath, secureMacro)
    local button = CreateFrameWithBackdrop(
        "Button",
        "PACT" .. key:gsub("^%l", string.upper) .. "Button",
        panel,
        secureMacro and "SecureActionButtonTemplate" or nil
    )

    button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    button:RegisterForClicks("LeftButtonUp")
    button.key = key

    ApplyBackdrop(button, 0.05, 0.05, 0.05, 0.92, 0.35, 0.35, 0.35, 1)

    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetPoint("TOPLEFT", button, "TOPLEFT", 4, -4)
    button.icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -4, 4)
    button.icon:SetTexture(iconPath)
    button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    button.disabledOverlay = button:CreateTexture(nil, "OVERLAY")
    button.disabledOverlay:SetAllPoints(button.icon)
    button.disabledOverlay:SetColorTexture(0, 0, 0, 0.58)
    button.disabledOverlay:Hide()

    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    button:SetScript("OnEnter", function(self)
        ShowButtonTooltip(self, self.key)
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    button:SetScript("OnMouseDown", function(self)
        if not self:IsEnabled() then
            return
        end
        self.icon:ClearAllPoints()
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -3, 3)
    end)
    button:SetScript("OnMouseUp", function(self)
        self.icon:ClearAllPoints()
        self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4)
        self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -4, 4)
    end)
    button:SetScript("OnEnable", function(self)
        self.icon:SetVertexColor(1, 1, 1)
        self.disabledOverlay:Hide()
    end)
    button:SetScript("OnDisable", function(self)
        self.icon:SetVertexColor(0.45, 0.45, 0.45)
        self.disabledOverlay:Show()
    end)

    if secureMacro then
        button:SetAttribute("type1", "macro")
    end

    buttons[key] = button
    return button
end

local function RunReadyCheck()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local fn = DoReadyCheck
    if not fn and C_PartyInfo then
        fn = C_PartyInfo.DoReadyCheck
    end

    if fn then
        fn()
    else
        Print(L.READY_UNAVAILABLE)
    end
end

local function RunRoleCheck()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local fn = InitiateRolePoll
    if not fn and C_PartyInfo then
        fn = C_PartyInfo.InitiateRolePoll
    end

    if fn then
        fn()
        MarkRoleCheckPending()
    else
        Print(L.ROLE_UNAVAILABLE)
    end
end

local function RunPullCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    if IsRoleCheckPending() then
        Print(L.ROLE_PENDING)
        return
    end

    local seconds = db.pullSeconds

    if RunSlashCommand("/pull " .. tostring(seconds)) then
        return
    elseif RunSlashCommand("/countdown " .. tostring(seconds)) then
        return
    elseif C_PartyInfo and C_PartyInfo.DoCountdown then
        C_PartyInfo.DoCountdown(seconds)
    elseif RunMacroText then
        RunMacroText("/pull " .. tostring(seconds))
    else
        Print(L.PULL_UNAVAILABLE)
    end
end

local function RunBreakCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    if IsRoleCheckPending() then
        Print(L.ROLE_PENDING)
        return
    end

    local command = ExpandBreakCommand()
    if RunSlashCommand(command) then
        breakCancelPending = true
        breakCancelToken = breakCancelToken + 1
        local token = breakCancelToken
        if C_Timer and C_Timer.After then
            C_Timer.After((db.breakMinutes * 60) + 1, function()
                if breakCancelToken == token then
                    breakCancelPending = nil
                end
            end)
        end
        return
    elseif RunMacroText then
        RunMacroText(command)
        breakCancelPending = true
        breakCancelToken = breakCancelToken + 1
        local token = breakCancelToken
        if C_Timer and C_Timer.After then
            C_Timer.After((db.breakMinutes * 60) + 1, function()
                if breakCancelToken == token then
                    breakCancelPending = nil
                end
            end)
        end
    else
        Print(L.BREAK_UNAVAILABLE)
    end
end

local function RunCancelCountdown()
    if not HasPermission() then
        Print(L.NO_PERMISSION)
        return
    end

    local stoppedPull = RunSlashCommand("/pull 0") or RunSlashCommand("/countdown 0")
    local stoppedBreak

    if breakCancelPending then
        stoppedBreak = RunSlashCommand("/break 0")
        if stoppedBreak then
            breakCancelPending = nil
            breakCancelToken = breakCancelToken + 1
        end
    end

    if stoppedPull or stoppedBreak then
        return
    elseif C_PartyInfo and C_PartyInfo.DoCountdown then
        C_PartyInfo.DoCountdown(0)
    elseif RunMacroText then
        RunMacroText("/break 0")
        RunMacroText("/pull 0")
    else
        Print(L.PULL_UNAVAILABLE)
    end
end

local function UpdateLockState()
    if not panel or not handle then
        return
    end

    panel:SetMovable(not db.locked)
    handle:EnableMouse(not db.locked)
    handle:SetAlpha(db.locked and 0.35 or 1)
    handle:Show()
end

local function UpdatePanelState()
    if not panel then
        return
    end

    if InCombat() then
        pendingLayoutUpdate = true
        return
    end

    local available = IsAvailable()
    local enabled = available and HasPermission()

    panel:SetShown(available)
    for _, button in pairs(buttons) do
        button:SetEnabled(enabled)
    end
end

local function LayoutPanel()
    if not panel then
        return
    end

    if InCombat() then
        pendingLayoutUpdate = true
        return
    end

    pendingLayoutUpdate = nil

    local visibleKeys = {}
    for i = 1, #buttonOrder do
        local index = db.reverseOrder and (#buttonOrder - i + 1) or i
        local key = buttonOrder[index]
        if key ~= "cancel" or db.showCancelButton then
            visibleKeys[#visibleKeys + 1] = key
        end
    end

    local visibleCount = #visibleKeys
    local handleSideSpace = HANDLE_WIDTH + GAP
    local handleTopSpace = HANDLE_WIDTH + GAP
    local buttonsWidth = BUTTON_SIZE
    local buttonsHeight = visibleCount * BUTTON_SIZE + math.max(visibleCount - 1, 0) * GAP
    local width
    local height

    panel:SetScale((db.panelScale or DEFAULT_DB.panelScale) / 100)

    if db.verticalLayout then
        width = buttonsWidth + PAD * 2
        height = PAD + handleTopSpace + buttonsHeight + PAD
    else
        width = PAD + handleSideSpace + buttonsHeight + PAD
        height = BUTTON_SIZE + PAD * 2
    end

    panel:SetSize(width, height)
    handle:Show()
    handle:SetSize(db.verticalLayout and BUTTON_SIZE or HANDLE_WIDTH, db.verticalLayout and HANDLE_WIDTH or BUTTON_SIZE)
    handle:ClearAllPoints()
    handle:SetPoint("TOPLEFT", panel, "TOPLEFT", PAD, -PAD)

    for _, dot in ipairs(handleDots) do
        dot:ClearAllPoints()
    end
    if db.verticalLayout then
        handleDots[1]:SetPoint("TOPLEFT", handle, "TOPLEFT", 5, -1)
        handleDots[2]:SetPoint("TOPLEFT", handle, "TOPLEFT", 11, -1)
        handleDots[3]:SetPoint("TOPLEFT", handle, "TOPLEFT", 17, -1)
        handleDots[4]:SetPoint("TOPLEFT", handle, "TOPLEFT", 5, -5)
        handleDots[5]:SetPoint("TOPLEFT", handle, "TOPLEFT", 11, -5)
        handleDots[6]:SetPoint("TOPLEFT", handle, "TOPLEFT", 17, -5)
    else
        handleDots[1]:SetPoint("TOPLEFT", handle, "TOPLEFT", 1, -5)
        handleDots[2]:SetPoint("TOPLEFT", handle, "TOPLEFT", 5, -5)
        handleDots[3]:SetPoint("TOPLEFT", handle, "TOPLEFT", 1, -11)
        handleDots[4]:SetPoint("TOPLEFT", handle, "TOPLEFT", 5, -11)
        handleDots[5]:SetPoint("TOPLEFT", handle, "TOPLEFT", 1, -17)
        handleDots[6]:SetPoint("TOPLEFT", handle, "TOPLEFT", 5, -17)
    end

    local x = db.verticalLayout and PAD or (PAD + handleSideSpace)
    local y = db.verticalLayout and -(PAD + handleTopSpace) or -PAD
    for _, key in ipairs(buttonOrder) do
        buttons[key]:Hide()
        buttons[key]:ClearAllPoints()
    end

    for _, key in ipairs(visibleKeys) do
        local button = buttons[key]
        button:SetShown(true)
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", panel, "TOPLEFT", x, y)
        if db.verticalLayout then
            y = y - BUTTON_SIZE - GAP
        else
            x = x + BUTTON_SIZE + GAP
        end
    end

    UpdateLockState()
    UpdatePanelState()
end

local function CreateHandleDot(parent, x, y)
    local dot = parent:CreateTexture(nil, "ARTWORK")
    dot:SetSize(2, 2)
    dot:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    dot:SetColorTexture(0.95, 0.82, 0.35, 0.85)
    return dot
end

local function CreatePanel()
    if panel then
        return
    end

    panel = CreateFrameWithBackdrop("Frame", "PACTFrame", UIParent)
    panel:SetFrameStrata("MEDIUM")
    panel:SetClampedToScreen(true)
    panel:EnableMouse(true)
    ApplyBackdrop(panel, 0.02, 0.02, 0.02, 0.72, 0.58, 0.45, 0.22, 0.95)

    handle = CreateFrame("Frame", nil, panel)
    handle:EnableMouse(true)
    handle:RegisterForDrag("LeftButton")
    handle:SetScript("OnDragStart", function()
        if db.locked then
            return
        end
        panel:StartMoving()
        panel:SetUserPlaced(false)
    end)
    handle:SetScript("OnDragStop", function()
        panel:StopMovingOrSizing()
        SavePosition()
    end)
    handle:SetScript("OnEnter", function(self)
        ShowButtonTooltip(self, "handle")
    end)
    handle:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    for i = 1, 6 do
        handleDots[i] = CreateHandleDot(handle, 1, -5)
    end

    CreateIconButton("ready", "Interface\\RaidFrame\\ReadyCheck-Ready", false)
    CreateIconButton("pull", "Interface\\Icons\\Ability_Warrior_Charge", false)
    CreateIconButton("role", "Interface\\Icons\\Ability_Warrior_DefensiveStance", false)
    CreateIconButton("break", "Interface\\Icons\\INV_Misc_PocketWatch_01", false)
    CreateIconButton("cancel", "Interface\\RaidFrame\\ReadyCheck-NotReady", false)

    buttons.ready:SetScript("OnClick", RunReadyCheck)
    buttons.pull:SetScript("OnClick", RunPullCountdown)
    buttons.role:SetScript("OnClick", RunRoleCheck)
    buttons["break"]:SetScript("OnClick", RunBreakCountdown)
    buttons.cancel:SetScript("OnClick", RunCancelCountdown)

    LoadPosition()
    LayoutPanel()
end

local function HookRaidManager(manager)
    if not manager or manager.PACTHideManagerHooked then
        return
    end

    manager:HookScript("OnShow", function(self)
        if db and db.hideRaidManager and not raidManagerRestoring then
            if InCombat() then
                pendingRaidManagerUpdate = true
                return
            end
            self:Hide()
            raidManagerHiddenByPACT = true
        end
    end)
    manager.PACTHideManagerHooked = true
end

local function DetachRaidContainer(manager)
    local container = manager and (manager.container or _G.CompactRaidFrameContainer)
    if not container or container:GetParent() ~= manager then
        return
    end

    raidContainerOriginalParent = manager
    container:SetParent(UIParent)
    raidContainerDetached = true
end

local function RestoreRaidManagerControls()
    if not raidManagerHiddenByPACT and not raidContainerDetached then
        return
    end

    local manager = _G.CompactRaidFrameManager
    if not manager then
        return
    end

    raidManagerRestoring = true
    local container = manager.container or _G.CompactRaidFrameContainer
    if raidContainerDetached and container then
        container:SetParent(raidContainerOriginalParent or manager)
    end
    if type(_G.CompactRaidFrameManager_UpdateShown) == "function" then
        _G.CompactRaidFrameManager_UpdateShown(manager)
    else
        manager:Show()
    end
    raidManagerRestoring = nil

    raidManagerHiddenByPACT = nil
    raidContainerDetached = nil
    raidContainerOriginalParent = nil
end

function PACT:ApplyRaidManagerVisibility()
    if not db then
        return
    end

    if InCombat() then
        pendingRaidManagerUpdate = true
        return
    end

    pendingRaidManagerUpdate = nil

    if db.hideRaidManager then
        local manager = _G.CompactRaidFrameManager
        if manager then
            HookRaidManager(manager)
            DetachRaidContainer(manager)
            manager:Hide()
            raidManagerHiddenByPACT = true
        end
    elseif raidManagerHiddenByPACT or raidContainerDetached then
        RestoreRaidManagerControls()
    end
end

local function PrintRaidManagerFrameState(label, frame)
    if not frame then
        Print("debug " .. label .. "=nil")
        return
    end

    local parent = frame:GetParent()
    local parentName = parent and parent.GetName and parent:GetName() or nil
    Print(string.format(
        "debug %s name=%s shown=%s visible=%s parent=%s",
        label,
        tostring(frame:GetName()),
        tostring(frame:IsShown()),
        tostring(frame:IsVisible()),
        tostring(parentName)
    ))
end

function PACT:DebugRaidManager()
    self:ApplyRaidManagerVisibility()

    local manager = _G.CompactRaidFrameManager
    Print(string.format(
        "debug option=%s combat=%s applied=%s pending=%s collapsed=%s",
        tostring(db and db.hideRaidManager),
        tostring(InCombat() and true or false),
        tostring(raidManagerHiddenByPACT and true or false),
        tostring(pendingRaidManagerUpdate and true or false),
        tostring(manager and manager.collapsed)
    ))
    PrintRaidManagerFrameState("manager", manager)
    PrintRaidManagerFrameState("display", manager and manager.displayFrame)
    PrintRaidManagerFrameState("toggleForward", manager and manager.toggleButtonForward)
    PrintRaidManagerFrameState("toggleBack", manager and manager.toggleButtonBack)
    PrintRaidManagerFrameState("raidContainer", manager and manager.container or _G.CompactRaidFrameContainer)
    PrintRaidManagerFrameState("partyFrame", _G.CompactPartyFrame)
end

local function CreateText(parent, text, template)
    local label = parent:CreateFontString(nil, "ARTWORK", template or "GameFontHighlight")
    label:SetText(text)
    label:SetJustifyH("LEFT")
    return label
end

local function CreateButton(parent, text, width)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(width or 140, 24)
    button:SetText(text)
    return button
end

local optionCheckIndex = 0

local function CreateCheckbox(parent, text, tooltip, onClick)
    optionCheckIndex = optionCheckIndex + 1
    local check = CreateFrame("CheckButton", "PACTOptionCheck" .. optionCheckIndex, parent, "InterfaceOptionsCheckButtonTemplate")
    local label = check.Text or _G[check:GetName() .. "Text"]
    if label then
        label:SetText(text)
    end
    check.tooltipText = tooltip
    check:SetScript("OnClick", function(self)
        onClick(self:GetChecked() and true or false)
    end)
    return check
end

local function CreateNumberStepper(parent, width, minimum, maximum, step, onValueChanged)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetSize(width, 24)
    frame.minimum = minimum
    frame.maximum = maximum
    frame.step = step

    local minus = CreateButton(frame, "-", 24)
    minus:SetPoint("LEFT", frame, "LEFT", 0, 0)
    frame.minus = minus

    local plus = CreateButton(frame, "+", 24)
    plus:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    frame.plus = plus

    local valueBox = CreateFrameWithBackdrop("Frame", nil, frame)
    valueBox:SetPoint("LEFT", minus, "RIGHT", 4, 0)
    valueBox:SetPoint("RIGHT", plus, "LEFT", -4, 0)
    valueBox:SetHeight(22)
    ApplyBackdrop(valueBox, 0.02, 0.02, 0.02, 0.85, 0.55, 0.55, 0.55, 1)
    frame.valueBox = valueBox

    local valueText = CreateText(valueBox, "", "GameFontHighlight")
    valueText:SetPoint("CENTER", valueBox, "CENTER", 0, 0)
    valueText:SetJustifyH("CENTER")
    frame.valueText = valueText

    function frame:SetValue(value)
        value = ClampInt(value, self.minimum, self.maximum, self.minimum)
        self.value = value
        self.valueText:SetText(tostring(value))
    end

    function frame:Change(delta)
        self:SetValue((self.value or self.minimum) + delta)
        onValueChanged(self.value)
    end

    minus:SetScript("OnClick", function()
        frame:Change(-frame.step)
    end)
    plus:SetScript("OnClick", function()
        frame:Change(frame.step)
    end)

    frame:EnableMouse(true)
    frame:EnableMouseWheel(true)
    frame:SetScript("OnMouseWheel", function(self, delta)
        self:Change(delta > 0 and self.step or -self.step)
    end)

    return frame
end

local function RefreshOptions()
    if not optionsPanel or not db then
        return
    end

    optionsPanel.hideRaidManagerCheck:SetChecked(db.hideRaidManager)
    optionsPanel.showPanelCheck:SetChecked(db.showPanel)
    optionsPanel.lockCheck:SetChecked(db.locked)
    optionsPanel.showCancelCheck:SetChecked(db.showCancelButton)
    optionsPanel.verticalLayoutCheck:SetChecked(db.verticalLayout)
    optionsPanel.reverseOrderCheck:SetChecked(db.reverseOrder)

    optionsPanel.pullSecondsStepper:SetValue(db.pullSeconds)
    optionsPanel.breakMinutesStepper:SetValue(db.breakMinutes)
    optionsPanel.panelScaleStepper:SetValue(db.panelScale)
    optionsPanel.breakPreview:SetText(L.BREAK_PREVIEW:format(ExpandBreakCommand()))
end

local function SetPullSeconds(value)
    db.pullSeconds = ClampInt(value, 1, 3600, DEFAULT_DB.pullSeconds)
    RefreshOptions()
end

local function SetBreakMinutes(value)
    db.breakMinutes = ClampInt(value, 1, 60, DEFAULT_DB.breakMinutes)
    RefreshOptions()
end

local function SetPanelScale(value)
    db.panelScale = ClampInt(value, 80, 140, DEFAULT_DB.panelScale)
    LayoutPanel()
    RefreshOptions()
end

local function ResetPosition()
    db.position = CopyDefaults(DEFAULT_DB.position)
    LoadPosition()
    Print(L.RESET_POSITION)
end

local function ResetDefaults()
    local oldPosition = CopyDefaults(db.position)
    PACTDB = CopyDefaults(DEFAULT_DB)
    PACTDB.position = oldPosition
    db = PACTDB

    LayoutPanel()
    PACT:ApplyRaidManagerVisibility()
    RefreshOptions()
end

local function CreateOptionsPanel()
    if optionsPanel then
        return optionsPanel
    end

    local panelFrame = CreateFrame("Frame", "PACTOptionsPanel", UIParent)
    panelFrame.name = L.ADDON_NAME
    panelFrame:SetSize(620, 360)

    local title = CreateText(panelFrame, L.OPTIONS_TITLE, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -16)

    local desc = CreateText(panelFrame, L.OPTIONS_DESC, "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)

    panelFrame.hideRaidManagerCheck = CreateCheckbox(panelFrame, L.HIDE_RAID_MANAGER, L.HIDE_RAID_MANAGER_TIP, function(value)
        db.hideRaidManager = value
        PACT:ApplyRaidManagerVisibility()
        RefreshOptions()
    end)
    panelFrame.hideRaidManagerCheck:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -64)

    panelFrame.showPanelCheck = CreateCheckbox(panelFrame, L.SHOW_PANEL, L.SHOW_PANEL_TIP, function(value)
        db.showPanel = value
        UpdatePanelState()
        RefreshOptions()
    end)
    panelFrame.showPanelCheck:SetPoint("TOPLEFT", panelFrame.hideRaidManagerCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.lockCheck = CreateCheckbox(panelFrame, L.LOCK_PANEL, L.LOCK_PANEL_TIP, function(value)
        db.locked = value
        LayoutPanel()
        RefreshOptions()
    end)
    panelFrame.lockCheck:SetPoint("TOPLEFT", panelFrame.showPanelCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.showCancelCheck = CreateCheckbox(panelFrame, L.SHOW_CANCEL, L.SHOW_CANCEL_TIP, function(value)
        db.showCancelButton = value
        LayoutPanel()
        RefreshOptions()
    end)
    panelFrame.showCancelCheck:SetPoint("TOPLEFT", panelFrame.lockCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.verticalLayoutCheck = CreateCheckbox(panelFrame, L.VERTICAL_LAYOUT, L.VERTICAL_LAYOUT_TIP, function(value)
        db.verticalLayout = value
        LayoutPanel()
        RefreshOptions()
    end)
    panelFrame.verticalLayoutCheck:SetPoint("TOPLEFT", panelFrame.showCancelCheck, "BOTTOMLEFT", 0, -8)

    panelFrame.reverseOrderCheck = CreateCheckbox(panelFrame, L.REVERSE_ORDER, L.REVERSE_ORDER_TIP, function(value)
        db.reverseOrder = value
        LayoutPanel()
        RefreshOptions()
    end)
    panelFrame.reverseOrderCheck:SetPoint("TOPLEFT", panelFrame.verticalLayoutCheck, "BOTTOMLEFT", 0, -8)

    local pullLabel = CreateText(panelFrame, L.PULL_SECONDS .. " (" .. L.SECONDS .. ")", "GameFontNormal")
    pullLabel:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 330, -64)

    panelFrame.pullSecondsStepper = CreateNumberStepper(panelFrame, 118, 1, 3600, 1, SetPullSeconds)
    panelFrame.pullSecondsStepper:SetPoint("TOPLEFT", pullLabel, "BOTTOMLEFT", 4, -6)

    local breakLabel = CreateText(panelFrame, L.BREAK_MINUTES .. " (" .. L.MINUTES .. ")", "GameFontNormal")
    breakLabel:SetPoint("TOPLEFT", panelFrame.pullSecondsStepper, "BOTTOMLEFT", -4, -24)

    panelFrame.breakMinutesStepper = CreateNumberStepper(panelFrame, 118, 1, 60, 1, SetBreakMinutes)
    panelFrame.breakMinutesStepper:SetPoint("TOPLEFT", breakLabel, "BOTTOMLEFT", 4, -6)

    panelFrame.breakPreview = CreateText(panelFrame, "", "GameFontHighlightSmall")
    panelFrame.breakPreview:SetPoint("TOPLEFT", panelFrame.breakMinutesStepper, "BOTTOMLEFT", -4, -14)

    local scaleLabel = CreateText(panelFrame, L.PANEL_SCALE .. " (" .. L.PERCENT .. ")", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", panelFrame.breakPreview, "BOTTOMLEFT", 0, -24)

    panelFrame.panelScaleStepper = CreateNumberStepper(panelFrame, 118, 80, 140, 5, SetPanelScale)
    panelFrame.panelScaleStepper:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 4, -6)

    local resetPositionButton = CreateButton(panelFrame, L.RESET_POS_BUTTON, 130)
    resetPositionButton:SetPoint("TOPLEFT", panelFrame, "TOPLEFT", 16, -318)
    resetPositionButton:SetScript("OnClick", function()
        ResetPosition()
        RefreshOptions()
    end)

    local resetDefaultsButton = CreateButton(panelFrame, L.RESET_DEFAULTS_BUTTON, 140)
    resetDefaultsButton:SetPoint("LEFT", resetPositionButton, "RIGHT", 8, 0)
    resetDefaultsButton:SetScript("OnClick", ResetDefaults)

    optionsPanel = panelFrame
    RefreshOptions()
    return optionsPanel
end

local function RegisterInterfaceOptions()
    local panelFrame = CreateOptionsPanel()

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        settingsCategory = Settings.RegisterCanvasLayoutCategory(panelFrame, panelFrame.name)
        Settings.RegisterAddOnCategory(settingsCategory)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panelFrame)
    end
end

local function DetachOptionsPanel()
    if not optionsPanel then
        return
    end

    optionsPanel:SetParent(UIParent)
    optionsPanel:ClearAllPoints()
    optionsPanel:Hide()
end

function PACT:OpenInterfaceOptions()
    CreateOptionsPanel()
    if standaloneWindow and standaloneWindow:IsShown() then
        standaloneWindow:Hide()
    elseif standaloneWindow and optionsPanel:GetParent() == standaloneWindow.content then
        DetachOptionsPanel()
    end
    RefreshOptions()

    if Settings and Settings.OpenToCategory and settingsCategory then
        local id = settingsCategory.GetID and settingsCategory:GetID() or settingsCategory.ID or settingsCategory
        Settings.OpenToCategory(id)
    elseif InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
    end
end

local function CreateStandaloneWindow()
    if standaloneWindow then
        return standaloneWindow
    end

    local ok, window = pcall(CreateFrame, "Frame", "PACTConfigWindow", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not window then
        window = CreateFrame("Frame", "PACTConfigWindow", UIParent)
        ApplyBackdrop(window, 0.02, 0.02, 0.02, 0.94, 0.55, 0.55, 0.55, 1)
    end

    window:SetSize(660, 430)
    window:SetPoint("CENTER")
    window:SetFrameStrata("FULLSCREEN_DIALOG")
    window:SetToplevel(true)
    window:EnableMouse(true)
    window:SetMovable(true)
    window:RegisterForDrag("LeftButton")
    window:SetScript("OnDragStart", window.StartMoving)
    window:SetScript("OnDragStop", window.StopMovingOrSizing)
    window:SetScript("OnHide", function()
        if optionsPanel and optionsPanel:GetParent() == window.content then
            DetachOptionsPanel()
        end
    end)
    window:Hide()

    if UISpecialFrames then
        table.insert(UISpecialFrames, "PACTConfigWindow")
    end

    local title = CreateText(window, L.OPTIONS_TITLE, "GameFontHighlight")
    title:SetPoint("TOP", window, "TOP", 0, -6)

    local content = CreateFrame("Frame", nil, window)
    content:SetPoint("TOPLEFT", window, "TOPLEFT", 16, -34)
    content:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -16, 16)
    window.content = content

    standaloneWindow = window
    return standaloneWindow
end

function PACT:OpenStandaloneOptions()
    local window = CreateStandaloneWindow()
    local panelFrame = CreateOptionsPanel()

    panelFrame:SetParent(window.content)
    panelFrame:ClearAllPoints()
    panelFrame:SetPoint("TOPLEFT", window.content, "TOPLEFT", 0, 0)
    panelFrame:SetSize(620, 360)
    panelFrame:Show()

    RefreshOptions()
    window:Show()
    window:Raise()
end

local function RegisterSlashCommands()
    SLASH_PACT1 = "/pact"

    SlashCmdList.PACT = function(message)
        message = (message or ""):match("^%s*(.-)%s*$") or ""
        local command = string.lower(message)

        if command == "" or command == "config" or command == "options" or command == "opcoes" then
            PACT:OpenStandaloneOptions()
        elseif command == "lock" then
            db.locked = true
            LayoutPanel()
            RefreshOptions()
            Print(L.LOCKED)
        elseif command == "unlock" then
            db.locked = false
            LayoutPanel()
            RefreshOptions()
            Print(L.UNLOCKED)
        elseif command == "reset" then
            ResetPosition()
        elseif command == "blizzard" then
            PACT:OpenInterfaceOptions()
        elseif command == "debug" or command == "debug raid" then
            PACT:DebugRaidManager()
        elseif command == "help" then
            Print(L.HELP)
        else
            Print(L.HELP)
        end
    end
end

function PACT:PLAYER_REGEN_ENABLED()
    if pendingLayoutUpdate then
        LayoutPanel()
    end
    if pendingRaidManagerUpdate then
        self:ApplyRaidManagerVisibility()
    end
    UpdatePanelState()
end

function PACT:PLAYER_LOGOUT()
    RestoreRaidManagerControls()
end

function PACT:PLAYER_ENTERING_WORLD()
    UpdatePanelState()
    self:ApplyRaidManagerVisibility()
    if C_Timer then
        C_Timer.After(1, function()
            PACT:ApplyRaidManagerVisibility()
        end)
    end
end

function PACT:GROUP_ROSTER_UPDATE()
    UpdatePanelState()
    self:ApplyRaidManagerVisibility()
end

function PACT:PARTY_LEADER_CHANGED()
    UpdatePanelState()
end

function PACT:RAID_ROSTER_UPDATE()
    UpdatePanelState()
end

function PACT:ROLE_POLL_BEGIN()
    MarkRoleCheckPending()
end

function PACT:PLAYER_ROLES_ASSIGNED()
    ClearRoleCheckPending()
end

function PACT:ADDON_LOADED(addonName)
    if addonName == "Blizzard_CompactRaidFrames" then
        if db and db.hideRaidManager then
            C_Timer.After(0, function()
                PACT:ApplyRaidManagerVisibility()
            end)
        end
        return
    end

    if addonName ~= ADDON_NAME then
        return
    end

    EnsureDb()
    CreatePanel()
    RegisterInterfaceOptions()
    RegisterSlashCommands()
    RefreshOptions()

    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("GROUP_ROSTER_UPDATE")
    self:RegisterEvent("PARTY_LEADER_CHANGED")
    self:RegisterEvent("RAID_ROSTER_UPDATE")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_LOGOUT")
    self:RegisterEvent("ROLE_POLL_BEGIN")
    self:RegisterEvent("PLAYER_ROLES_ASSIGNED")

    self:ApplyRaidManagerVisibility()
    Print(L.LOADED)
end

PACT:SetScript("OnEvent", function(self, event, ...)
    if self[event] then
        self[event](self, ...)
    end
end)

PACT:RegisterEvent("ADDON_LOADED")
