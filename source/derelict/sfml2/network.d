/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.sfml2.network;

public import derelict.util.loader;

private {
    import derelict.util.system;
    import derelict.sfml2.system;

    static if( Derelict_OS_Windows )
        enum libNames = "csfml-network.dll,csfml-network-2.dll,csfml-network-2.3.dll";
    else static if( Derelict_OS_Mac )
        enum libNames = "libcsfml-network.dylib,libcsfml-network.2.dylib,libcsfml-network.2.3.dylib";
    else static if( Derelict_OS_Posix )
        enum libNames = "libcsfml-network.so,libcsfml-network.so.2,libcsfml-network.so.2.3";
    else
        static assert( 0, "Need to implement SFML2 Network libNames for this operating system." );
}

// Network/Types.h
struct sfFtpDirectoryResponse;
struct sfFtpListingResponse;
struct sfFtpResponse;
struct sfFtp;
struct sfHttpRequest;
struct sfHttpResponse;
struct sfHttp;
struct sfPacket;
struct sfSocketSelector;
struct sfTcpListener;
struct sfTcpSocket;
struct sfUdpSocket;

// Network/Ftp.h
alias sfFtpTransferMode = int;
enum {
    sfFtpBinary,
    sfFtpAscii,
    sfFtpEbcdic,
}

alias sfFtpStatus = int;
enum {
    sfFtpRestartMarkerReply = 110,
    sfFtpServiceReadySoon = 120,
    sfFtpDataConnectionAlreadyOpened = 125,
    sfFtpOpeningDataConnection = 150,
    sfFtpOk = 200,
    sfFtpPointlessCommand = 202,
    sfFtpSystemStatus = 211,
    sfFtpDirectoryStatus = 212,
    sfFtpFileStatus = 213,
    sfFtpHelpMessage = 214,
    sfFtpSystemType = 215,
    sfFtpServiceReady = 220,
    sfFtpClosingConnection = 221,
    sfFtpDataConnectionOpened = 225,
    sfFtpClosingDataConnection = 226,
    sfFtpEnteringPassiveMode = 227,
    sfFtpLoggedIn = 230,
    sfFtpFileActionOk = 250,
    sfFtpDirectoryOk = 257,
    sfFtpNeedPassword = 331,
    sfFtpNeedAccountToLogIn = 332,
    sfFtpNeedInformation = 350,
    sfFtpServiceUnavailable = 421,
    sfFtpDataConnectionUnavailable = 425,
    sfFtpTransferAborted = 426,
    sfFtpFileActionAborted = 450,
    sfFtpLocalError = 451,
    sfFtpInsufficientStorageSpace = 452,
    sfFtpCommandUnknown = 500,
    sfFtpParametersUnknown = 501,
    sfFtpCommandNotImplemented = 502,
    sfFtpBadCommandSequence = 503,
    sfFtpParameterNotImplemented = 504,
    sfFtpNotLoggedIn = 530,
    sfFtpNeedAccountToStore = 532,
    sfFtpFileUnavailable = 550,
    sfFtpPageTypeUnknown = 551,
    sfFtpNotEnoughMemory = 552,
    sfFtpFilenameNotAllowed = 553,
    sfFtpInvalidResponse = 1000,
    sfFtpConnectionFailed = 1001,
    sfFtpConnectionClosed = 1002,
    sfFtpInvalidFile = 1003,
}

// Network/Http.h
alias sfHttpMethod = int;
enum {
    sfHttpGet,
    sfHttpPost,
    sfHttpHead,
    sfHttpPut,
    sfHttpDelete
}

alias sfHttpStatus = int;
enum {
    sfHttpOk = 200,
    sfHttpCreated = 201,
    sfHttpAccepted = 202,
    sfHttpNoContent = 204,
    sfHttpMultipleChoices = 300,
    sfHttpMovedPermanently = 301,
    sfHttpMovedTemporarily = 302,
    sfHttpNotModified = 304,
    sfHttpBadRequest = 400,
    sfHttpUnauthorized = 401,
    sfHttpForbidden = 403,
    sfHttpNotFound = 404,
    sfHttpInternalServerError = 500,
    sfHttpNotImplemented = 501,
    sfHttpBadGateway = 502,
    sfHttpServiceNotAvailable = 503,
    sfHttpInvalidResponse = 1000,
    sfHttpConnectionFailed = 1001,
}

// Network/IpAddress.h
struct sfIpAddress {
    char[16] address;
}

immutable( sfIpAddress ) sfIpAddress_None;

// Todo
//immutable(sfIpAddress) sfIpAddress_LocalHost =
//immutable(sfIpAddress) sfIpAddress_Broadcast =

// Network/SocketStatus.h
alias sfSocketStatus = int;
enum {
    sfSocketDone,
    sfSocketNotReady,
    sfSocketPartial,
    sfSocketDisconnected,
    sfSocketError
}

extern( C ) @nogc nothrow {
    // Network/Ftp.h
    alias da_sfFtpListingResponse_destroy = void function( sfFtpListingResponse* );
    alias da_sfFtpListingResponse_isOk = sfBool function( const( sfFtpListingResponse )* );
    alias da_sfFtpListingResponse_getStatus = sfFtpStatus function( const( sfFtpListingResponse )* );
    alias da_sfFtpListingResponse_getMessage = const( char )* function( const( sfFtpListingResponse )* );
    alias da_sfFtpListingResponse_getCount = size_t function( const( sfFtpListingResponse )* );
    alias da_sfFtpListingResponse_getName = const( char )* function( const( sfFtpListingResponse )*,size_t );
    alias da_sfFtpDirectoryResponse_destroy = void function( sfFtpDirectoryResponse* );
    alias da_sfFtpDirectoryResponse_isOk = sfBool function( const( sfFtpDirectoryResponse )* );
    alias da_sfFtpDirectoryResponse_getStatus = sfFtpStatus function( const( sfFtpDirectoryResponse )* );
    alias da_sfFtpDirectoryResponse_getMessage = const( char )* function( const( sfFtpDirectoryResponse )* );
    alias da_sfFtpDirectoryResponse_getDirectory = const( char )* function( const( sfFtpDirectoryResponse )* );
    alias da_sfFtpResponse_destroy = void function( sfFtpResponse* );
    alias da_sfFtpResponse_isOk = sfBool function( const( sfFtpResponse )* );
    alias da_sfFtpResponse_getStatus = sfFtpStatus function( const( sfFtpResponse )* );
    alias da_sfFtpResponse_getMessage = const( char )* function( const( sfFtpResponse )* );
    alias da_sfFtp_create = sfFtp* function();
    alias da_sfFtp_destroy = void function( sfFtp* );
    alias da_sfFtp_connect = sfFtpResponse* function( sfFtp*,sfIpAddress,ushort,sfTime );
    alias da_sfFtp_loginAnonymous = sfFtpResponse* function( sfFtp* );
    alias da_sfFtp_login = sfFtpResponse* function( sfFtp*,const( char )*,const( char )* );
    alias da_sfFtp_disconnect = sfFtpResponse* function( sfFtp* );
    alias da_sfFtp_keepAlive = sfFtpResponse* function( sfFtp* );
    alias da_sfFtp_getWorkingDirectory = sfFtpDirectoryResponse* function( sfFtp* );
    alias da_sfFtp_getDirectoryListing = sfFtpListingResponse* function( sfFtp*,const( char )* );
    alias da_sfFtp_changeDirectory = sfFtpResponse* function( sfFtp*,const( char )* );
    alias da_sfFtp_parentDirectory = sfFtpResponse* function( sfFtp* );
    alias da_sfFtp_createDirectory = sfFtpResponse* function( sfFtp*,const( char )* );
    alias da_sfFtp_deleteDirectory = sfFtpResponse* function( sfFtp*,const( char )* );
    alias da_sfFtp_renameFile = sfFtpResponse* function( sfFtp*,const( char )*,const( char )* );
    alias da_sfFtp_deleteFile = sfFtpResponse* function( sfFtp*,const( char )* );
    alias da_sfFtp_download = sfFtpResponse* function( sfFtp*,const( char )*,const( char )*,sfFtpTransferMode );
    alias da_sfFtp_upload = sfFtpResponse* function( sfFtp*,const( char )*,const( char )*,sfFtpTransferMode );

    // Network/Http.h
    alias da_sfHttpRequest_create = sfHttpRequest* function();
    alias da_sfHttpRequest_destroy = void function( sfHttpRequest* );
    alias da_sfHttpRequest_setField = void function( sfHttpRequest*,const( char )*,const( char )* );
    alias da_sfHttpRequest_setMethod = void function( sfHttpRequest*,sfHttpMethod );
    alias da_sfHttpRequest_setUri = void function( sfHttpRequest*,const( char )* );
    alias da_sfHttpRequest_setHttpVersion = void function( sfHttpRequest*,uint,uint );
    alias da_sfHttpRequest_setBody = void function( sfHttpRequest*,const( char )* );
    alias da_sfHttpResponse_destroy = void function( sfHttpResponse* );
    alias da_sfHttpResponse_getField = const( char )* function( const( sfHttpResponse )*,const( char )* );
    alias da_sfHttpResponse_getStatus = sfHttpStatus function( const( sfHttpResponse )* );
    alias da_sfHttpResponse_getMajorVersion = uint function( const( sfHttpResponse )* );
    alias da_sfHttpResponse_getMinorVersion = uint function( const( sfHttpResponse )* );
    alias da_sfHttpResponse_getBody = const( char )* function( const( sfHttpResponse )* );
    alias da_sfHttp_create = sfHttp* function();
    alias da_sfHttp_destroy = void function( sfHttp* );
    alias da_sfHttp_setHost = void function( sfHttp*,const( char )*,ushort );
    alias da_sfHttp_sendRequest = sfHttpResponse* function( sfHttp*,const( sfHttpRequest )*,sfTime );

    // Network/IPAddress.h
    alias da_sfIpAddress_fromString = sfIpAddress function( const( char )* );
    alias da_sfIpAddress_fromBytes = sfIpAddress function( sfUint8,sfUint8,sfUint8,sfUint8 );
    alias da_sfIpAddress_fromInteger = sfIpAddress function( sfUint32 );
    alias da_sfIpAddress_toString = void function( sfIpAddress,char* );
    alias da_sfIpAddress_toInteger = sfUint32 function( sfIpAddress aress );
    alias da_sfIpAddress_getLocalAddress = sfIpAddress function();
    alias da_sfIpAddress_getPublicAddress = sfIpAddress function( sfTime );

    // Network/Packet.h
    alias da_sfPacket_create = sfPacket* function();
    alias da_sfPacket_copy = sfPacket* function( const( sfPacket )* );
    alias da_sfPacket_destroy = void function( sfPacket* );
    alias da_sfPacket_append = void function( sfPacket*,const( void )*,size_t );
    alias da_sfPacket_clear = void function( sfPacket* );
    alias da_sfPacket_getData = const( void )* function( const( sfPacket )* );
    alias da_sfPacket_getDataSize = size_t function( const( sfPacket )* );
    alias da_sfPacket_endOfPacket = sfBool function( const( sfPacket )* );
    alias da_sfPacket_canRead = sfBool function( const( sfPacket )* );
    alias da_sfPacket_readBool = sfBool function( sfPacket* );
    alias da_sfPacket_readInt8 = sfInt8 function( sfPacket* );
    alias da_sfPacket_readUint8 = sfUint8 function( sfPacket* );
    alias da_sfPacket_readInt16 = sfInt16 function( sfPacket* );
    alias da_sfPacket_readUint16 = sfUint16 function( sfPacket* );
    alias da_sfPacket_readInt32 = sfInt32 function( sfPacket* );
    alias da_sfPacket_readUint32 = sfUint32 function( sfPacket* );
    alias da_sfPacket_readFloat = float function( sfPacket* );
    alias da_sfPacket_readDouble = double function( sfPacket* );
    alias da_sfPacket_readString = void function( sfPacket*,char* );
    alias da_sfPacket_readWideString = void function( sfPacket*,wchar* );
    alias da_sfPacket_writeBool = void function( sfPacket*,sfBool );
    alias da_sfPacket_writeInt8 = void function( sfPacket*,sfInt8 );
    alias da_sfPacket_writeUint8 = void function( sfPacket*,sfUint8 );
    alias da_sfPacket_writeInt16 = void function( sfPacket*,sfInt16 );
    alias da_sfPacket_writeUint16 = void function( sfPacket*,sfUint16 );
    alias da_sfPacket_writeInt32 = void function( sfPacket*,sfInt32 );
    alias da_sfPacket_writeUint32 = void function( sfPacket*,sfUint32 );
    alias da_sfPacket_writeFloat = void function( sfPacket*,float );
    alias da_sfPacket_writeDouble = void function( sfPacket*,double );
    alias da_sfPacket_writeString = void function( sfPacket*,const( char )* );
    alias da_sfPacket_writeWideString = void function( sfPacket*,const( wchar )* );

    // Network/SocketSelector.h
    alias da_sfSocketSelector_create = sfSocketSelector* function();
    alias da_sfSocketSelector_copy = sfSocketSelector* function( const( sfSocketSelector )* );
    alias da_sfSocketSelector_destroy = void function( sfSocketSelector* );
    alias da_sfSocketSelector_addTcpListener = void function( sfSocketSelector*,sfTcpListener* );
    alias da_sfSocketSelector_addTcpSocket = void function( sfSocketSelector*,sfTcpSocket* );
    alias da_sfSocketSelector_addUdpSocket = void function( sfSocketSelector*,sfUdpSocket* );
    alias da_sfSocketSelector_removeTcpListener = void function( sfSocketSelector*,sfTcpListener* );
    alias da_sfSocketSelector_removeTcpSocket = void function( sfSocketSelector*,sfTcpSocket* );
    alias da_sfSocketSelector_removeUdpSocket = void function( sfSocketSelector*,sfUdpSocket* );
    alias da_sfSocketSelector_clear = void function( sfSocketSelector* );
    alias da_sfSocketSelector_wait = sfBool function( sfSocketSelector*,sfTime );
    alias da_sfSocketSelector_isTcpListenerReady = sfBool function( const( sfSocketSelector )*,sfTcpListener* );
    alias da_sfSocketSelector_isTcpSocketReady = sfBool function( const( sfSocketSelector )*,sfTcpSocket* );
    alias da_sfSocketSelector_isUdpSocketReady = sfBool function( const( sfSocketSelector )*,sfUdpSocket* );

    // Network/TcpListener.h
    alias da_sfTcpListener_create = sfTcpListener* function();
    alias da_sfTcpListener_destroy = void function( sfTcpListener* );
    alias da_sfTcpListener_setBlocking = void function( sfTcpListener*,sfBool );
    alias da_sfTcpListener_isBlocking = sfBool function( const( sfTcpListener )* );
    alias da_sfTcpListener_getLocalPort = ushort function( const( sfTcpListener )* );
    alias da_sfTcpListener_listen = sfSocketStatus function( sfTcpListener*,ushort );
    alias da_sfTcpListener_accept = sfSocketStatus function( sfTcpListener*,sfTcpSocket** );

    // Network/TcpSocket.h
    alias da_sfTcpSocket_create = sfTcpSocket* function();
    alias da_sfTcpSocket_destroy = void function( sfTcpSocket* );
    alias da_sfTcpSocket_setBlocking = void function( sfTcpSocket*,sfBool );
    alias da_sfTcpSocket_isBlocking = sfBool function( const( sfTcpSocket )* );
    alias da_sfTcpSocket_getLocalPort = ushort function( const( sfTcpSocket )* );
    alias da_sfTcpSocket_getRemoteAddress = sfIpAddress function( const( sfTcpSocket )* );
    alias da_sfTcpSocket_getRemotePort = ushort function( const( sfTcpSocket )* );
    alias da_sfTcpSocket_connect = sfSocketStatus function( sfTcpSocket*,sfIpAddress,ushort,sfTime );
    alias da_sfTcpSocket_disconnect = void function( sfTcpSocket* );
    alias da_sfTcpSocket_send = sfSocketStatus function( sfTcpSocket*,const( void )*,size_t );
    alias da_sfTcpSocket_sendPartial = sfSocketStatus function( sfTcpSocket*,const( void )*,size_t,size_t* );
    alias da_sfTcpSocket_receive = sfSocketStatus function( sfTcpSocket*,void*,size_t,size_t* );
    alias da_sfTcpSocket_sendPacket = sfSocketStatus function( sfTcpSocket*,sfPacket* );
    alias da_sfTcpSocket_receivePacket = sfSocketStatus function( sfTcpSocket*,sfPacket* );

    // Network/UdpSocket.h
    alias da_sfUdpSocket_create = sfUdpSocket* function();
    alias da_sfUdpSocket_destroy = void function( sfUdpSocket* );
    alias da_sfUdpSocket_setBlocking = void function( sfUdpSocket*,sfBool );
    alias da_sfUdpSocket_isBlocking = sfBool function( const( sfUdpSocket )* );
    alias da_sfUdpSocket_getLocalPort = short function( const( sfUdpSocket )* );
    alias da_sfUdpSocket_bind = sfSocketStatus function( sfUdpSocket*,ushort );
    alias da_sfUdpSocket_unbind = void function( sfUdpSocket* );
    alias da_sfUdpSocket_send = sfSocketStatus function( sfUdpSocket*,const( void )*,size_t,sfIpAddress,ushort );
    alias da_sfUdpSocket_receive = sfSocketStatus function( sfUdpSocket*,void*,size_t,size_t*,sfIpAddress*,ushort* );
    alias da_sfUdpSocket_sendPacket = sfSocketStatus function( sfUdpSocket*,sfPacket*,sfIpAddress,ushort );
    alias da_sfUdpSocket_receivePacket = sfSocketStatus function( sfUdpSocket*,sfPacket*,sfIpAddress*,ushort* );
    alias da_sfUdpSocket_maxDatagramSize = uint function();
}

__gshared {
    da_sfFtpListingResponse_destroy sfFtpListingResponse_destroy;
    da_sfFtpListingResponse_isOk sfFtpListingResponse_isOk;
    da_sfFtpListingResponse_getStatus sfFtpListingResponse_getStatus;
    da_sfFtpListingResponse_getMessage sfFtpListingResponse_getMessage;
    da_sfFtpListingResponse_getCount sfFtpListingResponse_getCount;
    da_sfFtpListingResponse_getName sfFtpListingResponse_getName;
    da_sfFtpDirectoryResponse_destroy sfFtpDirectoryResponse_destroy;
    da_sfFtpDirectoryResponse_isOk sfFtpDirectoryResponse_isOk;
    da_sfFtpDirectoryResponse_getStatus sfFtpDirectoryResponse_getStatus;
    da_sfFtpDirectoryResponse_getMessage sfFtpDirectoryResponse_getMessage;
    da_sfFtpDirectoryResponse_getDirectory sfFtpDirectoryResponse_getDirectory;
    da_sfFtpResponse_destroy sfFtpResponse_destroy;
    da_sfFtpResponse_isOk sfFtpResponse_isOk;
    da_sfFtpResponse_getStatus sfFtpResponse_getStatus;
    da_sfFtpResponse_getMessage sfFtpResponse_getMessage;
    da_sfFtp_create sfFtp_create;
    da_sfFtp_destroy sfFtp_destroy;
    da_sfFtp_connect sfFtp_connect;
    da_sfFtp_loginAnonymous sfFtp_loginAnonymous;
    da_sfFtp_login sfFtp_login;
    da_sfFtp_disconnect sfFtp_disconnect;
    da_sfFtp_keepAlive sfFtp_keepAlive;
    da_sfFtp_getWorkingDirectory sfFtp_getWorkingDirectory;
    da_sfFtp_getDirectoryListing sfFtp_getDirectoryListing;
    da_sfFtp_changeDirectory sfFtp_changeDirectory;
    da_sfFtp_parentDirectory sfFtp_parentDirectory;
    da_sfFtp_createDirectory sfFtp_createDirectory;
    da_sfFtp_deleteDirectory sfFtp_deleteDirectory;
    da_sfFtp_renameFile sfFtp_renameFile;
    da_sfFtp_deleteFile sfFtp_deleteFile;
    da_sfFtp_download sfFtp_download;
    da_sfFtp_upload sfFtp_upload;

    da_sfHttpRequest_create sfHttpRequest_create;
    da_sfHttpRequest_destroy sfHttpRequest_destroy;
    da_sfHttpRequest_setField sfHttpRequest_setField;
    da_sfHttpRequest_setMethod sfHttpRequest_setMethod;
    da_sfHttpRequest_setUri sfHttpRequest_setUri;
    da_sfHttpRequest_setHttpVersion sfHttpRequest_setHttpVersion;
    da_sfHttpRequest_setBody sfHttpRequest_setBody;
    da_sfHttpResponse_destroy sfHttpResponse_destroy;
    da_sfHttpResponse_getField sfHttpResponse_getField;
    da_sfHttpResponse_getStatus sfHttpResponse_getStatus;
    da_sfHttpResponse_getMajorVersion sfHttpResponse_getMajorVersion;
    da_sfHttpResponse_getMinorVersion sfHttpResponse_getMinorVersion;
    da_sfHttpResponse_getBody sfHttpResponse_getBody;
    da_sfHttp_create sfHttp_create;
    da_sfHttp_destroy sfHttp_destroy;
    da_sfHttp_setHost sfHttp_setHost;
    da_sfHttp_sendRequest sfHttp_sendRequest;

    da_sfIpAddress_fromString sfIpAddress_fromString;
    da_sfIpAddress_fromBytes sfIpAddress_fromBytes;
    da_sfIpAddress_fromInteger sfIpAddress_fromInteger;
    da_sfIpAddress_toString sfIpAddress_toString;
    da_sfIpAddress_toInteger sfIpAddress_toInteger;
    da_sfIpAddress_getLocalAddress sfIpAddress_getLocalAddress;
    da_sfIpAddress_getPublicAddress sfIpAddress_getPublicAddress;

    da_sfPacket_create sfPacket_create;
    da_sfPacket_copy sfPacket_copy;
    da_sfPacket_destroy sfPacket_destroy;
    da_sfPacket_append sfPacket_append;
    da_sfPacket_clear sfPacket_clear;
    da_sfPacket_getData sfPacket_getData;
    da_sfPacket_getDataSize sfPacket_getDataSize;
    da_sfPacket_endOfPacket sfPacket_endOfPacket;
    da_sfPacket_canRead sfPacket_canRead;
    da_sfPacket_readBool sfPacket_readBool;
    da_sfPacket_readInt8 sfPacket_readInt8;
    da_sfPacket_readUint8 sfPacket_readUint8;
    da_sfPacket_readInt16 sfPacket_readInt16;
    da_sfPacket_readUint16 sfPacket_readUint16;
    da_sfPacket_readInt32 sfPacket_readInt32;
    da_sfPacket_readUint32 sfPacket_readUint32;
    da_sfPacket_readFloat sfPacket_readFloat;
    da_sfPacket_readDouble sfPacket_readDouble;
    da_sfPacket_readString sfPacket_readString;
    da_sfPacket_readWideString sfPacket_readWideString;
    da_sfPacket_writeBool sfPacket_writeBool;
    da_sfPacket_writeInt8 sfPacket_writeInt8;
    da_sfPacket_writeUint8 sfPacket_writeUint8;
    da_sfPacket_writeInt16 sfPacket_writeInt16;
    da_sfPacket_writeUint16 sfPacket_writeUint16;
    da_sfPacket_writeInt32 sfPacket_writeInt32;
    da_sfPacket_writeUint32 sfPacket_writeUint32;
    da_sfPacket_writeFloat sfPacket_writeFloat;
    da_sfPacket_writeDouble sfPacket_writeDouble;
    da_sfPacket_writeString sfPacket_writeString;
    da_sfPacket_writeWideString sfPacket_writeWideString;

    da_sfSocketSelector_create sfSocketSelector_create;
    da_sfSocketSelector_copy sfSocketSelector_copy;
    da_sfSocketSelector_destroy sfSocketSelector_destroy;
    da_sfSocketSelector_addTcpListener sfSocketSelector_addTcpListener;
    da_sfSocketSelector_addTcpSocket sfSocketSelector_addTcpSocket;
    da_sfSocketSelector_addUdpSocket sfSocketSelector_addUdpSocket;
    da_sfSocketSelector_removeTcpListener sfSocketSelector_removeTcpListener;
    da_sfSocketSelector_removeTcpSocket sfSocketSelector_removeTcpSocket;
    da_sfSocketSelector_removeUdpSocket sfSocketSelector_removeUdpSocket;
    da_sfSocketSelector_clear sfSocketSelector_clear;
    da_sfSocketSelector_wait sfSocketSelector_wait;
    da_sfSocketSelector_isTcpListenerReady sfSocketSelector_isTcpListenerReady;
    da_sfSocketSelector_isTcpSocketReady sfSocketSelector_isTcpSocketReady;
    da_sfSocketSelector_isUdpSocketReady sfSocketSelector_isUdpSocketReady;

    da_sfTcpListener_create sfTcpListener_create;
    da_sfTcpListener_destroy sfTcpListener_destroy;
    da_sfTcpListener_setBlocking sfTcpListener_setBlocking;
    da_sfTcpListener_isBlocking sfTcpListener_isBlocking;
    da_sfTcpListener_getLocalPort sfTcpListener_getLocalPort;
    da_sfTcpListener_listen sfTcpListener_listen;
    da_sfTcpListener_accept sfTcpListener_accept;

    da_sfTcpSocket_create sfTcpSocket_create;
    da_sfTcpSocket_destroy sfTcpSocket_destroy;
    da_sfTcpSocket_setBlocking sfTcpSocket_setBlocking;
    da_sfTcpSocket_isBlocking sfTcpSocket_isBlocking;
    da_sfTcpSocket_getLocalPort sfTcpSocket_getLocalPort;
    da_sfTcpSocket_getRemoteAddress sfTcpSocket_getRemoteAddress;
    da_sfTcpSocket_getRemotePort sfTcpSocket_getRemotePort;
    da_sfTcpSocket_connect sfTcpSocket_connect;
    da_sfTcpSocket_disconnect sfTcpSocket_disconnect;
    da_sfTcpSocket_send sfTcpSocket_send;
    da_sfTcpSocket_sendPartial sfTcpSocket_sendPartial;
    da_sfTcpSocket_receive sfTcpSocket_receive;
    da_sfTcpSocket_sendPacket sfTcpSocket_sendPacket;
    da_sfTcpSocket_receivePacket sfTcpSocket_receivePacket;

    da_sfUdpSocket_create sfUdpSocket_create;
    da_sfUdpSocket_destroy sfUdpSocket_destroy;
    da_sfUdpSocket_setBlocking sfUdpSocket_setBlocking;
    da_sfUdpSocket_isBlocking sfUdpSocket_isBlocking;
    da_sfUdpSocket_getLocalPort sfUdpSocket_getLocalPort;
    da_sfUdpSocket_bind sfUdpSocket_bind;
    da_sfUdpSocket_unbind sfUdpSocket_unbind;
    da_sfUdpSocket_send sfUdpSocket_send;
    da_sfUdpSocket_receive sfUdpSocket_receive;
    da_sfUdpSocket_sendPacket sfUdpSocket_sendPacket;
    da_sfUdpSocket_receivePacket sfUdpSocket_receivePacket;
    da_sfUdpSocket_maxDatagramSize sfUdpSocket_maxDatagramSize;
}

class DerelictSFML2NetworkLoader : SharedLibLoader {
    public this() {
        super( libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&sfFtpListingResponse_destroy, "sfFtpListingResponse_destroy" );
        bindFunc( cast( void** )&sfFtpListingResponse_isOk, "sfFtpListingResponse_isOk" );
        bindFunc( cast( void** )&sfFtpListingResponse_getStatus, "sfFtpListingResponse_getStatus" );
        bindFunc( cast( void** )&sfFtpListingResponse_getMessage, "sfFtpListingResponse_getMessage" );
        bindFunc( cast( void** )&sfFtpListingResponse_getCount, "sfFtpListingResponse_getCount" );
        bindFunc( cast( void** )&sfFtpListingResponse_getName, "sfFtpListingResponse_getName" );
        bindFunc( cast( void** )&sfFtpDirectoryResponse_destroy, "sfFtpDirectoryResponse_destroy" );
        bindFunc( cast( void** )&sfFtpDirectoryResponse_isOk, "sfFtpDirectoryResponse_isOk" );
        bindFunc( cast( void** )&sfFtpDirectoryResponse_getStatus, "sfFtpDirectoryResponse_getStatus" );
        bindFunc( cast( void** )&sfFtpDirectoryResponse_getMessage, "sfFtpDirectoryResponse_getMessage" );
        bindFunc( cast( void** )&sfFtpDirectoryResponse_getDirectory, "sfFtpDirectoryResponse_getDirectory" );
        bindFunc( cast( void** )&sfFtpResponse_destroy, "sfFtpResponse_destroy" );
        bindFunc( cast( void** )&sfFtpResponse_isOk, "sfFtpResponse_isOk" );
        bindFunc( cast( void** )&sfFtpResponse_getStatus, "sfFtpResponse_getStatus" );
        bindFunc( cast( void** )&sfFtpResponse_getMessage, "sfFtpResponse_getMessage" );
        bindFunc( cast( void** )&sfFtp_create, "sfFtp_create" );
        bindFunc( cast( void** )&sfFtp_destroy, "sfFtp_destroy" );
        bindFunc( cast( void** )&sfFtp_connect, "sfFtp_connect" );
        bindFunc( cast( void** )&sfFtp_loginAnonymous, "sfFtp_loginAnonymous" );
        bindFunc( cast( void** )&sfFtp_login, "sfFtp_login" );
        bindFunc( cast( void** )&sfFtp_disconnect, "sfFtp_disconnect" );
        bindFunc( cast( void** )&sfFtp_keepAlive, "sfFtp_keepAlive" );
        bindFunc( cast( void** )&sfFtp_getWorkingDirectory, "sfFtp_getWorkingDirectory" );
        bindFunc( cast( void** )&sfFtp_getDirectoryListing, "sfFtp_getDirectoryListing" );
        bindFunc( cast( void** )&sfFtp_changeDirectory, "sfFtp_changeDirectory" );
        bindFunc( cast( void** )&sfFtp_parentDirectory, "sfFtp_parentDirectory" );
        bindFunc( cast( void** )&sfFtp_createDirectory, "sfFtp_createDirectory" );
        bindFunc( cast( void** )&sfFtp_deleteDirectory, "sfFtp_deleteDirectory" );
        bindFunc( cast( void** )&sfFtp_renameFile, "sfFtp_renameFile" );
        bindFunc( cast( void** )&sfFtp_deleteFile, "sfFtp_deleteFile" );
        bindFunc( cast( void** )&sfFtp_download, "sfFtp_download" );
        bindFunc( cast( void** )&sfFtp_upload, "sfFtp_upload" );
        bindFunc( cast( void** )&sfHttpRequest_create, "sfHttpRequest_create" );
        bindFunc( cast( void** )&sfHttpRequest_destroy, "sfHttpRequest_destroy" );
        bindFunc( cast( void** )&sfHttpRequest_setField, "sfHttpRequest_setField" );
        bindFunc( cast( void** )&sfHttpRequest_setMethod, "sfHttpRequest_setMethod" );
        bindFunc( cast( void** )&sfHttpRequest_setUri, "sfHttpRequest_setUri" );
        bindFunc( cast( void** )&sfHttpRequest_setHttpVersion, "sfHttpRequest_setHttpVersion" );
        bindFunc( cast( void** )&sfHttpRequest_setBody, "sfHttpRequest_setBody" );
        bindFunc( cast( void** )&sfHttpResponse_destroy, "sfHttpResponse_destroy" );
        bindFunc( cast( void** )&sfHttpResponse_getField, "sfHttpResponse_getField" );
        bindFunc( cast( void** )&sfHttpResponse_getStatus, "sfHttpResponse_getStatus" );
        bindFunc( cast( void** )&sfHttpResponse_getMajorVersion, "sfHttpResponse_getMajorVersion" );
        bindFunc( cast( void** )&sfHttpResponse_getMinorVersion, "sfHttpResponse_getMinorVersion" );
        bindFunc( cast( void** )&sfHttpResponse_getBody, "sfHttpResponse_getBody" );
        bindFunc( cast( void** )&sfHttp_create, "sfHttp_create" );
        bindFunc( cast( void** )&sfHttp_destroy, "sfHttp_destroy" );
        bindFunc( cast( void** )&sfHttp_setHost, "sfHttp_setHost" );
        bindFunc( cast( void** )&sfHttp_sendRequest, "sfHttp_sendRequest" );
        bindFunc( cast( void** )&sfIpAddress_fromString, "sfIpAddress_fromString" );
        bindFunc( cast( void** )&sfIpAddress_fromBytes, "sfIpAddress_fromBytes" );
        bindFunc( cast( void** )&sfIpAddress_fromInteger, "sfIpAddress_fromInteger" );
        bindFunc( cast( void** )&sfIpAddress_toString, "sfIpAddress_toString" );
        bindFunc( cast( void** )&sfIpAddress_toInteger, "sfIpAddress_toInteger" );
        bindFunc( cast( void** )&sfIpAddress_getLocalAddress, "sfIpAddress_getLocalAddress" );
        bindFunc( cast( void** )&sfIpAddress_getPublicAddress, "sfIpAddress_getPublicAddress" );
        bindFunc( cast( void** )&sfPacket_create, "sfPacket_create" );
        bindFunc( cast( void** )&sfPacket_copy, "sfPacket_copy" );
        bindFunc( cast( void** )&sfPacket_destroy, "sfPacket_destroy" );
        bindFunc( cast( void** )&sfPacket_append, "sfPacket_append" );
        bindFunc( cast( void** )&sfPacket_clear, "sfPacket_clear" );
        bindFunc( cast( void** )&sfPacket_getData, "sfPacket_getData" );
        bindFunc( cast( void** )&sfPacket_getDataSize, "sfPacket_getDataSize" );
        bindFunc( cast( void** )&sfPacket_endOfPacket, "sfPacket_endOfPacket" );
        bindFunc( cast( void** )&sfPacket_canRead, "sfPacket_canRead" );
        bindFunc( cast( void** )&sfPacket_readBool, "sfPacket_readBool" );
        bindFunc( cast( void** )&sfPacket_readInt8, "sfPacket_readInt8" );
        bindFunc( cast( void** )&sfPacket_readUint8, "sfPacket_readUint8" );
        bindFunc( cast( void** )&sfPacket_readInt16, "sfPacket_readInt16" );
        bindFunc( cast( void** )&sfPacket_readUint16, "sfPacket_readUint16" );
        bindFunc( cast( void** )&sfPacket_readInt32, "sfPacket_readInt32" );
        bindFunc( cast( void** )&sfPacket_readUint32, "sfPacket_readUint32" );
        bindFunc( cast( void** )&sfPacket_readFloat, "sfPacket_readFloat" );
        bindFunc( cast( void** )&sfPacket_readDouble, "sfPacket_readDouble" );
        bindFunc( cast( void** )&sfPacket_readString, "sfPacket_readString" );
        bindFunc( cast( void** )&sfPacket_readWideString, "sfPacket_readWideString" );
        bindFunc( cast( void** )&sfPacket_writeBool, "sfPacket_writeBool" );
        bindFunc( cast( void** )&sfPacket_writeInt8, "sfPacket_writeInt8" );
        bindFunc( cast( void** )&sfPacket_writeUint8, "sfPacket_writeUint8" );
        bindFunc( cast( void** )&sfPacket_writeInt16, "sfPacket_writeInt16" );
        bindFunc( cast( void** )&sfPacket_writeUint16, "sfPacket_writeUint16" );
        bindFunc( cast( void** )&sfPacket_writeInt32, "sfPacket_writeInt32" );
        bindFunc( cast( void** )&sfPacket_writeUint32, "sfPacket_writeUint32" );
        bindFunc( cast( void** )&sfPacket_writeFloat, "sfPacket_writeFloat" );
        bindFunc( cast( void** )&sfPacket_writeDouble, "sfPacket_writeDouble" );
        bindFunc( cast( void** )&sfPacket_writeString, "sfPacket_writeString" );
        bindFunc( cast( void** )&sfPacket_writeWideString, "sfPacket_writeWideString" );
        bindFunc( cast( void** )&sfSocketSelector_create, "sfSocketSelector_create" );
        bindFunc( cast( void** )&sfSocketSelector_copy, "sfSocketSelector_copy" );
        bindFunc( cast( void** )&sfSocketSelector_destroy, "sfSocketSelector_destroy" );
        bindFunc( cast( void** )&sfSocketSelector_addTcpListener, "sfSocketSelector_addTcpListener" );
        bindFunc( cast( void** )&sfSocketSelector_addTcpSocket, "sfSocketSelector_addTcpSocket" );
        bindFunc( cast( void** )&sfSocketSelector_addUdpSocket, "sfSocketSelector_addUdpSocket" );
        bindFunc( cast( void** )&sfSocketSelector_removeTcpListener, "sfSocketSelector_removeTcpListener" );
        bindFunc( cast( void** )&sfSocketSelector_removeTcpSocket, "sfSocketSelector_removeTcpSocket" );
        bindFunc( cast( void** )&sfSocketSelector_removeUdpSocket, "sfSocketSelector_removeUdpSocket" );
        bindFunc( cast( void** )&sfSocketSelector_clear, "sfSocketSelector_clear" );
        bindFunc( cast( void** )&sfSocketSelector_wait, "sfSocketSelector_wait" );
        bindFunc( cast( void** )&sfSocketSelector_isTcpListenerReady, "sfSocketSelector_isTcpListenerReady" );
        bindFunc( cast( void** )&sfSocketSelector_isTcpSocketReady, "sfSocketSelector_isTcpSocketReady" );
        bindFunc( cast( void** )&sfSocketSelector_isUdpSocketReady, "sfSocketSelector_isUdpSocketReady" );
        bindFunc( cast( void** )&sfTcpListener_create, "sfTcpListener_create" );
        bindFunc( cast( void** )&sfTcpListener_destroy, "sfTcpListener_destroy" );
        bindFunc( cast( void** )&sfTcpListener_setBlocking, "sfTcpListener_setBlocking" );
        bindFunc( cast( void** )&sfTcpListener_isBlocking, "sfTcpListener_isBlocking" );
        bindFunc( cast( void** )&sfTcpListener_getLocalPort, "sfTcpListener_getLocalPort" );
        bindFunc( cast( void** )&sfTcpListener_listen, "sfTcpListener_listen" );
        bindFunc( cast( void** )&sfTcpListener_accept, "sfTcpListener_accept" );
        bindFunc( cast( void** )&sfTcpSocket_create, "sfTcpSocket_create" );
        bindFunc( cast( void** )&sfTcpSocket_destroy, "sfTcpSocket_destroy" );
        bindFunc( cast( void** )&sfTcpSocket_setBlocking, "sfTcpSocket_setBlocking" );
        bindFunc( cast( void** )&sfTcpSocket_isBlocking, "sfTcpSocket_isBlocking" );
        bindFunc( cast( void** )&sfTcpSocket_getLocalPort, "sfTcpSocket_getLocalPort" );
        bindFunc( cast( void** )&sfTcpSocket_getRemoteAddress, "sfTcpSocket_getRemoteAddress" );
        bindFunc( cast( void** )&sfTcpSocket_getRemotePort, "sfTcpSocket_getRemotePort" );
        bindFunc( cast( void** )&sfTcpSocket_connect, "sfTcpSocket_connect" );
        bindFunc( cast( void** )&sfTcpSocket_disconnect, "sfTcpSocket_disconnect" );
        bindFunc( cast( void** )&sfTcpSocket_send, "sfTcpSocket_send" );
        bindFunc( cast( void** )&sfTcpSocket_sendPartial, "sfTcpSocket_sendPartial" );
        bindFunc( cast( void** )&sfTcpSocket_receive, "sfTcpSocket_receive" );
        bindFunc( cast( void** )&sfTcpSocket_sendPacket, "sfTcpSocket_sendPacket" );
        bindFunc( cast( void** )&sfTcpSocket_receivePacket, "sfTcpSocket_receivePacket" );
        bindFunc( cast( void** )&sfUdpSocket_create, "sfUdpSocket_create" );
        bindFunc( cast( void** )&sfUdpSocket_destroy, "sfUdpSocket_destroy" );
        bindFunc( cast( void** )&sfUdpSocket_setBlocking, "sfUdpSocket_setBlocking" );
        bindFunc( cast( void** )&sfUdpSocket_isBlocking, "sfUdpSocket_isBlocking" );
        bindFunc( cast( void** )&sfUdpSocket_getLocalPort, "sfUdpSocket_getLocalPort" );
        bindFunc( cast( void** )&sfUdpSocket_bind, "sfUdpSocket_bind" );
        bindFunc( cast( void** )&sfUdpSocket_unbind, "sfUdpSocket_unbind" );
        bindFunc( cast( void** )&sfUdpSocket_send, "sfUdpSocket_send" );
        bindFunc( cast( void** )&sfUdpSocket_receive, "sfUdpSocket_receive" );
        bindFunc( cast( void** )&sfUdpSocket_sendPacket, "sfUdpSocket_sendPacket" );
        bindFunc( cast( void** )&sfUdpSocket_receivePacket, "sfUdpSocket_receivePacket" );
        bindFunc( cast( void** )&sfUdpSocket_maxDatagramSize, "sfUdpSocket_maxDatagramSize" );
    }
}

__gshared DerelictSFML2NetworkLoader DerelictSFML2Network;

shared static this() {
    DerelictSFML2Network = new DerelictSFML2NetworkLoader();
}
