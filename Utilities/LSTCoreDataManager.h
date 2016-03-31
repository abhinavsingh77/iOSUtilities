//
//  LSTCoreDataManager.h
//
//  Created by Abhinav Singh on 3/31/16.
//

@import CoreData;

FOUNDATION_EXPORT NSString * const AppDatabaseName;

@interface LSTCoreDataManager : NSObject {
	
}

-(void)saveDataBase;

-(id)newObjectForClassString:(NSString*)classStr;
-(id)newObjectForClassString:(NSString*)classStr andContext:(NSManagedObjectContext*)context;

#pragma mark - Retriving Database Objects

-(NSArray*)allObjectsOfClass:(NSString*)className;
-(NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate;
-(NSArray*)allObjectsOfClass:(NSString*)className sortDescriptor:(NSSortDescriptor*)sortDescri;
-(NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescri;
-(NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescri limit:(NSInteger)limit;

-(NSArray*)resultsForFetchRequest:(NSFetchRequest*)request;
-(NSArray*)distinctObjectsOfClass:(NSString*)classNa forProperties:(NSArray*)props;

#pragma mark - Counting

-(NSInteger)countForObjectsOfClass:(NSString*)className;
-(NSInteger)countForObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate;

@end
