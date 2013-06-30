
#import "CSVHandler.h"


NSMutableArray* readCSVFile (NSString *fileName)
{
    NSString *appHomePath = NSHomeDirectory();
    NSString *appDocPath = [appHomePath stringByAppendingPathComponent:@"ReMapp1.app"];
    NSString *filePath= [appDocPath stringByAppendingPathComponent:fileName];
    NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [text componentsSeparatedByString:@"\n"];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSString *row in lines) {
        NSArray *items = [row componentsSeparatedByString:@","];
        [data addObject:items];
    }
    return data;
}

void addCSVFile (NSString *fileName, NSString *line)
{
    NSString *appHomePath = NSHomeDirectory();
    NSString *appDocPath = [appHomePath stringByAppendingPathComponent:@"ReMapp1.app"];
    NSString *filePath= [appDocPath stringByAppendingPathComponent:fileName];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    // 既存チェック
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath
                             contents:[NSData data]
                           attributes:nil];
    }
    
    NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    NSData* data = [line dataUsingEncoding:NSShiftJISStringEncoding];
    [fileHandle writeData:data];
    [fileHandle closeFile];
}

